import random
from flask import Flask, request, jsonify, session, redirect, url_for, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, login_user, login_required, logout_user, current_user, UserMixin
from werkzeug.security import check_password_hash, generate_password_hash
from datetime import datetime
import secrets

app = Flask(__name__)
app.config['SECRET_KEY'] = secrets.token_hex(16)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://reuben:Rhiannon14@localhost:5432/game_recommendation'
db = SQLAlchemy(app)

login_manager = LoginManager(app)
login_manager.login_view = '/login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

class User(db.Model, UserMixin):
    __tablename__ = 'users'
    
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

    comments = db.relationship('Comment', backref='author')

    def is_active(self):
        return True

    def get_id(self):
        return str(self.user_id)

class BoardGame(db.Model):
    __tablename__ = 'board_game'

    boardgame_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text)
    player_count = db.Column(db.Integer, nullable=False)
    complexity = db.Column(db.String(50), nullable=False)

    # Specify the foreign key relationship for the comments
    comments = db.relationship('Comment', backref='game_board', foreign_keys='Comment.board_game_id')

class ConsoleGame(db.Model):
    __tablename__ = 'console_games'

    game_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text)
    player_count = db.Column(db.Integer, nullable=False)
    complexity = db.Column(db.String(50), nullable=False)
    console_id = db.Column(db.Integer, db.ForeignKey('gaming_consoles.console_id'), nullable=False)

    # Define a relationship with the 'Comment' model and specify a different backref name
    comments = db.relationship('Comment', backref='game', foreign_keys='Comment.console_game_id')
    
    console = db.relationship('GamingConsole', backref=db.backref('games', lazy=True))

class GamingConsole(db.Model):
    __tablename__ = 'gaming_consoles'
    
    console_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    manufacturer = db.Column(db.String(100), nullable=False)

class Comment(db.Model):
    __tablename__ = 'comments'

    comment_id = db.Column(db.Integer, primary_key=True, index=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    console_game_id = db.Column(db.Integer, db.ForeignKey('console_games.game_id'))
    board_game_id = db.Column(db.Integer, db.ForeignKey('board_game.boardgame_id'))
    game_id = db.Column(db.Integer, db.ForeignKey('board_game.boardgame_id'))  # Add game_id as a ForeignKey
    text = db.Column(db.String, nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    # Define relationships to other tables (Users, ConsoleGames, and BoardGames)
    user = db.relationship("User", back_populates="comments")
    console_game = db.relationship("ConsoleGame", back_populates="comments", foreign_keys=[console_game_id])
    board_game = db.relationship("BoardGame", back_populates="comments", foreign_keys=[board_game_id])

    # Use a single foreign key for the game (either console or board game)
    # and allow it to be nullable
    game_id = db.Column(db.Integer, nullable=True)

@app.route('/', methods=['GET'])
def welcome():
    return "Welcome to my Gaming API"

@app.route('/register', methods=['POST'])
def register():
    # Get user data from the request
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    # Check if the username already exists
    existing_user = User.query.filter_by(username=username).first()
    if existing_user:
        return jsonify({'message': 'Username already exists'}), 400

    # Hash the password before storing it
    hashed_password = generate_password_hash(password, method='sha256')

    # Create a new user and add it to the database
    new_user = User(username=username, password=hashed_password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    # Find the user by username
    user = User.query.filter_by(username=username).first()

    # Check if the user exists and if the password is correct
    if user and check_password_hash(user.password, password):
        # Log in the user using Flask-Login's login_user function
        login_user(user)
        return jsonify({'message': 'User logged in successfully'}), 200

    return jsonify({'message': 'Invalid username or password'}), 401

@app.route('/protected_route', methods=['GET'])
@login_required
def protected_route():
    # You can access the current_user object here
    return jsonify({'message': 'This is a protected route', 'user_id': current_user.user_id}), 200

@app.route('/logout', methods=['GET'])
@login_required
def logout():
    # Log out the user using Flask-Login's logout_user function
    logout_user()
    return jsonify({'message': 'User logged out successfully'}), 200

@app.route('/get_recommendations', methods=['GET'])
def get_recommendations():
    # Query the database to fetch all console games and board games with their associated consoles
    all_console_games = ConsoleGame.query.all()
    all_board_games = BoardGame.query.all()

    # Create a dictionary to store console information
    console_info = {console.console_id: {'name': console.name, 'manufacturer': console.manufacturer} for console in GamingConsole.query.all()}

    # Combine the results into a single list and add 'type' and 'console' fields
    all_games = [{'game': game, 'type': 'ConsoleGame', 'console': console_info[game.console_id]} for game in all_console_games] + \
                [{'game': game, 'type': 'BoardGame', 'console': None} for game in all_board_games]

    # Choose a random subset of games as recommendations
    num_recommendations = 2  # You can adjust the number of recommendations as needed
    recommendations = random.sample(all_games, num_recommendations)

    # Prepare the recommendation data to be returned as JSON
    recommendation_data = []

    for recommendation in recommendations:
        game_type = recommendation['type']
        game_info = recommendation['game']

        if game_type == 'ConsoleGame':
            recommendation_data.append({
                'type': game_type,  # Indicates whether it's a console or board game
                'game_id': game_info.game_id,  # Use the correct attribute name for ConsoleGame
                'title': game_info.title,
                'description': game_info.description,
                'player_count': game_info.player_count,
                'complexity': game_info.complexity,
                'console': recommendation['console']  # Information about the console (None for board games)
            })
        elif game_type == 'BoardGame':
            recommendation_data.append({
                'type': game_type,  # Indicates whether it's a console or board game
                'game_id': game_info.boardgame_id,  # Use the correct attribute name for BoardGame
                'title': game_info.title,
                'description': game_info.description,
                'player_count': game_info.player_count,
                'complexity': game_info.complexity,
                'console': None  # Board games don't have consoles
            })

    return jsonify({'recommendations': recommendation_data}), 200

@app.route('/add_comment', methods=['POST'])
def add_comment():
    # Check if the user is authenticated
    if not current_user.is_authenticated:
        return jsonify({'message': 'User is not authenticated'}), 401

    data = request.get_json()
    game_id = data.get('game_id')
    comment_text = data.get('comment_text')
    game_type = data.get('game_type')
    print('Received Game ID:', game_id)
    print('Received Game Type:', game_type)

    # Check if the game type is valid (ConsoleGame or BoardGame)
    if game_type not in ['ConsoleGame', 'BoardGame']:
        return jsonify({'message': 'Invalid game type'}), 400

    # Find the game based on the game type
    if game_type == 'ConsoleGame':
        game = ConsoleGame.query.get(game_id)
        if game:
            # Create a new comment associated with the game
            new_comment = Comment(user_id=current_user.user_id, text=comment_text, game_id=game.game_id)
        else:
            return jsonify({'message': 'Game not found'}), 404
    else:  # Assuming 'BoardGame'
        game = BoardGame.query.get(game_id)
        if game:
            # Create a new comment associated with the game
            new_comment = Comment(user_id=current_user.user_id, text=comment_text, game_id=game.boardgame_id)
        else:
            return jsonify({'message': 'Game not found'}), 404

    if game:
        # Create a new comment associated with the game
        new_comment = Comment(user_id=current_user.user_id, text=comment_text)

        if game_type == 'ConsoleGame':
            new_comment.console_game_id = game.game_id  # Use the correct foreign key
        else:  # Assuming 'BoardGame'
            new_comment.board_game_id = game.game_id  # Use the correct foreign key

        db.session.add(new_comment)
        db.session.commit()
        return jsonify({'message': 'Comment added successfully'}), 201
    else:
        return jsonify({'message': 'Game not found'}), 404
 
if __name__ == '__main__':
    app.run(debug=True)
