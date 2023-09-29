# Gaming_API

## R1. Identify a problem I am trying to solve

So as most gamers know sometimes its next to impossible to be able to decide on a new game to play or even an old game, so I created an API that will assist in recommending a couple of games for the user and also be able to provide a way to comment on that game almost like a review or even a way for the user to provide themselves an insight on how they felt when they played that game.

## R2. Why is it a problem that needs solving?

Honestly the best way to put it is simply like deciding on dinner, you need to eat but no one ever wants to pick on what to eat. Some times its the same with gaming, you have all these games you can play in various different ways but you dont know what to play and this is what this does, it suggest something you may not have or you may have and forgotten about

## R3 Why have I chosen this database system?

I actually really like Postgresql as a database system, its rather easy to use and since we're only storing minimal data we dont need something big. It is Free and open source as well. If for any reason though we were looking at expanding the amount of data being kept its easily scalable too. The drawbacks however are there is still a size limitation, doesnt have as many third-party integrations , can be very dificult to learn compared to simpler databases.

## R4 Identify and discuss the key functionalities and benefits of an ORM

An Object-Relational Mapping (ORM) is a programming technique and tool that allows developers to interact with relational databases using object-oriented programming concepts. ORMs provide a bridge between the database and application code, allowing developers to work with database entities as if they were regular Python, Java, or C# objects. It can offer low level SQL operations, They can work with various DBMS, can provide high-level methods for performing CRUD operations, makes sure that data meets specific constraints and it can simplfy the querying and navigation of related data.

## R5 Document all endpoints for your API

Welcome Message:

Endpoint: /
HTTP Method: GET
Description: Returns a welcome message when you access the root URL of the API.
User Registration:

Endpoint: /register
HTTP Method: POST
Description: Allows users to register by providing a username and password.
User Login:

Endpoint: /login
HTTP Method: POST
Description: Allows users to log in by providing a username and password.
Protected Route:

Endpoint: /protected_route
HTTP Method: GET
Description: A protected route that requires authentication. Only accessible to logged-in users.
User Logout:

Endpoint: /logout
HTTP Method: GET
Description: Allows logged-in users to log out.
Get Recommendations:

Endpoint: /get_recommendations
HTTP Method: GET
Description: Retrieves a list of gaming recommendations. The recommendations include console games and board games with associated console information.
Add Comment:

Endpoint: /add_comment
HTTP Method: POST
Description: Allows authenticated users to add comments about games. Requires specifying the game type (ConsoleGame or BoardGame) and game ID.

## R6 An ERD for my Application
Uploaded

## R7 Detail any third party services that your app will use

I use Flask-Login as a Flask extension for managing user sessions and authentication. It provides essential features like user login, session management, and login_required decorators, making user authentication a breeze in my application.

Flask-SQLAlchemy is another valuable extension I've incorporated. It seamlessly integrates SQLAlchemy, a renowned Object-Relational Mapping (ORM) library, with Flask. This integration simplifies database operations, allowing me to work with databases as Python objects, making database interactions smoother and more efficient.

Werkzeug is a handy utility library that comes bundled with Flask. I utilize its werkzeug.security module to securely hash passwords. While Werkzeug isn't a third-party library, it's still noteworthy for its role in enhancing security.

For form handling, I've integrated Flask-WTF, an extension that pairs up with WTForms, a powerful form handling library. This combination streamlines form creation, validation, and processing within my application, simplifying user interactions.

Additionally, I leverage the secrets module from the Python Standard Library to generate secure random tokens like secret keys, enhancing the overall security of my application.

Regarding the database, while PostgreSQL itself isn't a third-party service, my application relies on it extensively. I use a PostgreSQL database to store user data, game information, comments, and recommendations. This database service, even though not third-party, plays a pivotal role in ensuring data persistence and retrieval in my application.

## R8 Describe your projects models in terms of the relationships they have with each other

In my project, I've designed several models, each with specific relationships that define how they interact with one another.

First, I have the "User" model, which represents the application's users. This model has a one-to-many relationship with the "Comment" model. Users can create multiple comments, so this relationship allows me to link users to their respective comments easily.

Next, I have two distinct game models: "BoardGame" and "ConsoleGame." Both of these models have a one-to-many relationship with the "Comment" model as well. Users can comment on both board games and console games, so these relationships enable me to associate comments with the specific games they refer to.

To categorize console games, I also use the "GamingConsole" model, which represents various gaming consoles. This model has a one-to-many relationship with the "ConsoleGame" model, as a console can have multiple associated games.

Moreover, I've established a more generic relationship in the "Comment" model itself. I use a single foreign key, "game_id," which can link to either a console game or a board game. This design allows comments to be associated with a game, irrespective of whether it's a board or console game.

These relationships between my models form the backbone of my application, enabling users to interact with games and leave comments effectively.

## R9 Discuss the database relations to be implemented in your application

In my application, I have implemented several database relationships to ensure that data is organized efficiently and can be accessed as needed. These relationships are crucial for the overall functionality of the application. Here are the key database relations I've implemented:

User to Comment Relationship (One-to-Many): Each user in my application can create multiple comments. This one-to-many relationship allows users to leave comments on various games.

BoardGame to Comment Relationship (One-to-Many): The "BoardGame" model has a one-to-many relationship with the "Comment" model. This means that each board game can have multiple comments associated with it, allowing users to discuss and review board games.

ConsoleGame to Comment Relationship (One-to-Many): Similarly, the "ConsoleGame" model also has a one-to-many relationship with the "Comment" model. This relationship enables users to leave comments on console games.

GamingConsole to ConsoleGame Relationship (One-to-Many): To categorize and organize console games by the gaming console they are associated with, I've established a one-to-many relationship between the "GamingConsole" and "ConsoleGame" models. This allows each gaming console to have multiple associated console games.

Generic Game to Comment Relationship (One-to-Many): To create a more flexible relationship, I've introduced a generic one-to-many relationship within the "Comment" model itself. The "game_id" field in the "Comment" model can link to either a console game or a board game. This flexibility allows comments to be associated with a game, regardless of whether it's a console or board game.

These database relationships ensure that users can leave comments on both console and board games, and that games are properly categorized by gaming console. It also provides flexibility for future expansions or modifications to the application's functionality.

## R10 Describe the way tasks are allocated and tracked in your project

What I did was start off with finding an issue I regularly had, i created an ERD around it and continuously worked on it with ideas until I finally got the finished product I was happy with. Once I had completed that I knew I had to divide and conquer it all bit by bit, so what I did was create the database first so I had my generic information and started creating the endpoints one by one.

After each endpoint was created it would come with testing to ensure that it would work without any issues, if any issues came up I would make sure to fix it before moving onto the next endpoint.

First was the welcome page just to make sure that I had hooked up my database correct using the URI and that i could access information in there by creating a quick GET post to get some information in there. Once i knew it worked I started to work on other endpoints.

So the way that the tasks were allocated was based on priority, nothing else was going to work until I had a register and a login page, so those were the first tasks that were prioritised. To keep track of them I used Trello because i had used it before, I would assign tasks according to priority and then would track each endpoint in Trello, each time an endpoint had been completed and tested I would mark it off.

Once I got to the end of my application I would retest it all together and so long as they worked we were okay!