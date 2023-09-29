--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: board_game; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.board_game (
    boardgame_id integer NOT NULL,
    title character varying(120) NOT NULL,
    description character varying(200) NOT NULL,
    player_count integer NOT NULL,
    complexity character varying(20) NOT NULL
);


ALTER TABLE public.board_game OWNER TO reuben;

--
-- Name: board_game_boardgame_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.board_game_boardgame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.board_game_boardgame_id_seq OWNER TO reuben;

--
-- Name: board_game_boardgame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.board_game_boardgame_id_seq OWNED BY public.board_game.boardgame_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.comments (
    comment_id integer NOT NULL,
    user_id integer NOT NULL,
    console_game_id integer,
    board_game_id integer,
    text text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    game_id integer
);


ALTER TABLE public.comments OWNER TO reuben;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.comments_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_comment_id_seq OWNER TO reuben;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.comments_comment_id_seq OWNED BY public.comments.comment_id;


--
-- Name: console_games; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.console_games (
    game_id integer NOT NULL,
    title character varying(60) NOT NULL,
    description character varying(250) NOT NULL,
    player_count integer NOT NULL,
    complexity character varying(20) NOT NULL,
    console_id integer
);


ALTER TABLE public.console_games OWNER TO reuben;

--
-- Name: console_games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.console_games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.console_games_game_id_seq OWNER TO reuben;

--
-- Name: console_games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.console_games_game_id_seq OWNED BY public.console_games.game_id;


--
-- Name: gaming_consoles; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.gaming_consoles (
    console_id integer NOT NULL,
    name character varying(30) NOT NULL,
    manufacturer character varying(30) NOT NULL
);


ALTER TABLE public.gaming_consoles OWNER TO reuben;

--
-- Name: gaming_consoles_console_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.gaming_consoles_console_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gaming_consoles_console_id_seq OWNER TO reuben;

--
-- Name: gaming_consoles_console_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.gaming_consoles_console_id_seq OWNED BY public.gaming_consoles.console_id;


--
-- Name: recommendation; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.recommendation (
    recommendation_id integer NOT NULL,
    user_id integer,
    game_id integer
);


ALTER TABLE public.recommendation OWNER TO reuben;

--
-- Name: recommendation_recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.recommendation_recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recommendation_recommendation_id_seq OWNER TO reuben;

--
-- Name: recommendation_recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.recommendation_recommendation_id_seq OWNED BY public.recommendation.recommendation_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: reuben
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(80) NOT NULL,
    password character varying(200) DEFAULT NULL::character varying
);


ALTER TABLE public.users OWNER TO reuben;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: reuben
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO reuben;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: reuben
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.user_id;


--
-- Name: board_game boardgame_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.board_game ALTER COLUMN boardgame_id SET DEFAULT nextval('public.board_game_boardgame_id_seq'::regclass);


--
-- Name: comments comment_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.comments ALTER COLUMN comment_id SET DEFAULT nextval('public.comments_comment_id_seq'::regclass);


--
-- Name: console_games game_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.console_games ALTER COLUMN game_id SET DEFAULT nextval('public.console_games_game_id_seq'::regclass);


--
-- Name: gaming_consoles console_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.gaming_consoles ALTER COLUMN console_id SET DEFAULT nextval('public.gaming_consoles_console_id_seq'::regclass);


--
-- Name: recommendation recommendation_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.recommendation ALTER COLUMN recommendation_id SET DEFAULT nextval('public.recommendation_recommendation_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: board_game; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.board_game (boardgame_id, title, description, player_count, complexity) FROM stdin;
1	Catan	Settlers of Catan is a great strategy came to play with friends	3	Medium
2	Ticket To Ride	Ticket To Ride is a fun competitve game to claim railway routes in North America	2	Easy
5	Ticket to Ride	A railway-themed board game where players build train routes.	2	Easy
6	Pandemic	A cooperative game where players work together to stop global diseases.	2	Medium
7	Carcassonne	A tile-laying game where players create a medieval landscape.	2	Easy
8	Dominion	A deck-building card game where players build their own kingdoms.	2	Medium
9	7 Wonders	A card-drafting game where players develop civilizations over three ages.	2	Medium
10	Codenames	A word game of deduction and espionage.	4	Easy
11	Azul	A tile-laying game where players create beautiful patterns on their boards.	2	Medium
12	Splendor	A game of economic strategy where players collect gems and build a trading empire.	2	Medium
13	Scythe	A strategy game set in an alternate-history 1920s where players vie for control of an Eastern European landscape.	1	Hard
14	Twilight Struggle	A two-player game that simulates the Cold War struggle between the United States and the Soviet Union.	2	Hard
15	Terraforming Mars	A game where players work to terraform the Red Planet by developing infrastructure and resources.	1	Medium
16	Gloomhaven	A cooperative, campaign-driven dungeon-crawling game.	1	Hard
17	Betrayal at Baldur's Gate	A game of exploration and betrayal set in a haunted mansion.	3	Medium
18	Kingdomino	A tile-drafting and kingdom-building game.	2	Easy
19	Wingspan	A game focused on birdwatching and habitat-building.	1	Medium
20	Agricola	A game of farming and resource management.	1	Hard
21	Ticket to Ride: Europe	A European version of the original Ticket to Ride game.	2	Easy
22	Power Grid	A strategy game where players compete to supply cities with electricity.	2	Medium
23	Dead of Winter	A cooperative game of survival during a zombie apocalypse, with potential betrayers in the group.	2	Medium
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.comments (comment_id, user_id, console_game_id, board_game_id, text, "timestamp", game_id) FROM stdin;
3	3	1	\N	This is a test comment.	2023-09-29 13:58:56.589615	\N
\.


--
-- Data for Name: console_games; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.console_games (game_id, title, description, player_count, complexity, console_id) FROM stdin;
1	It Takes Two	A unique cooperative action-adventure game with puzzle-solving.	2	Medium	4
2	Outriders	Cooperative third-person shooter with RPG elements.	3	Medium	4
3	Overcooked! All You Can Eat	Chaotic culinary simulation game for teamwork.	4	Easy	4
4	Sackboy: A Big Adventure	Platformer with local and online co-op gameplay.	4	Easy	4
5	Riders Republic	Upcoming extreme sports game with cooperative multiplayer for 50 players.	50	Medium	4
6	Minecraft	Popular sandbox game with co-op and creative gameplay.	4	Medium	4
7	Little Big Planet 3	Charming and creative platformer with co-op play.	4	Easy	4
16	Halo Infinite	Master Chief returns in the latest installment of the iconic Halo series. Join the fight against the Banished on the stunning ringworld of Zeta Halo.	4	Intermediate	5
17	Forza Horizon 5	Experience the beauty and thrill of Mexico in this open-world racing game. Explore diverse landscapes and participate in epic races.	2	Intermediate	5
18	Resident Evil Village	Step into the shoes of Ethan Winters as he faces terrifying creatures in a mysterious village. Survival horror at its best.	1	Advanced	5
19	Hitman 3	Become the worlds greatest assassin, Agent 47. Travel to exotic locations and eliminate high-profile targets with creativity.	1	Advanced	5
20	Psychonauts 2	Join Razputin Aquato on a mind-bending adventure inside peoples minds. Uncover secrets and navigate surreal landscapes.	1	Intermediate	5
21	Back 4 Blood	Team up with friends to fight against hordes of infected in this cooperative first-person shooter. Its a spiritual successor to Left 4 Dead.	4	Advanced	5
22	The Medium	Delve into a psychological horror experience as Marianne, a medium who can perceive both the spirit world and reality.	1	Advanced	5
23	Scarlet Nexus	Take on the role of Yuito Sumeragi, a psionic warrior, and battle supernatural threats in a futuristic world filled with mysteries.	1	Intermediate	5
24	Ratchet & Clank: Rift Apart	Join Ratchet and his robotic buddy Clank as they jump through rifts across dimensions. Stunning visuals and inventive gameplay await.	2	Intermediate	5
25	The Legend of Zelda: Breath of the Wild	Embark on an epic adventure in the kingdom of Hyrule. Explore a vast open world, solve puzzles, and battle formidable foes.	1	Intermediate	7
26	Animal Crossing: New Horizons	Create your own island paradise in this relaxing life simulation game. Customize your home, interact with charming villagers, and enjoy island life.	1	Beginner	7
27	Super Mario Odyssey	Join Mario on a globe-trotting journey to rescue Princess Peach from Bowser. Explore diverse kingdoms and use your hat, Cappy, to possess objects and enemies.	1	Intermediate	7
28	Splatoon 2	Dive into fast-paced, ink-spraying battles in this colorful multiplayer shooter. Team up with friends and compete in exciting turf wars.	4	Intermediate	7
29	Mario Kart 8 Deluxe	Race against friends or AI in the ultimate kart racing game. Use power-ups, dodge obstacles, and aim for victory.	4	Intermediate	7
30	Pokémon Sword and Shield	Embark on a Pokémon adventure in the Galar region. Capture, train, and battle Pokémon in your quest to become the Champion.	1	Intermediate	7
31	Super Smash Bros. Ultimate	Fight with a roster of over 70 characters in this epic crossover brawler. Smash your opponents off the stage in intense battles.	4	Intermediate	7
32	Fire Emblem: Three Houses	Lead a group of students at the Officers Academy and engage in tactical battles. Your choices shape the fate of the land of Fódlan.	1	Advanced	7
33	Hades	Descend into the underworld as Zagreus and battle your way through hordes of mythical foes. Unearth secrets and improve your abilities in this roguelike game.	1	Advanced	7
34	The Witcher 3: Wild Hunt - Complete Edition	Experience the epic open-world RPG as Geralt of Rivia. Explore a vast fantasy world, make choices, and hunt monsters.	1	Advanced	7
35	The Last of Us Part II	Experience an emotionally charged story of survival in a post-apocalyptic world. Join Ellie on her journey for revenge and redemption.	1	Advanced	8
36	Ghost of Tsushima	Step into the shoes of samurai Jin Sakai on a quest to protect his home and people. Explore feudal Japan and embrace the way of the Ghost.	1	Intermediate	8
37	Red Dead Redemption 2	Live the life of an outlaw in the American Wild West. Make choices, build relationships, and confront the consequences of your actions.	1	Advanced	8
38	God of War (2018)	Follow Kratos and his son Atreus on a mythological journey in the world of Norse gods. Battle legendary creatures and unravel a gripping tale.	1	Advanced	8
39	Marvels Spider-Man	Swing through the streets of New York City as Spider-Man. Battle iconic villains and protect the city from threats.	1	Intermediate	8
40	Bloodborne	Face nightmarish creatures and uncover dark secrets in the city of Yharnam. This challenging action RPG is known for its intense gameplay.	1	Advanced	8
41	Horizon Zero Dawn	Explore a beautiful, post-apocalyptic world inhabited by robotic creatures. Play as Aloy and uncover the mysteries of her world.	1	Intermediate	8
42	Persona 5	Attend high school by day and lead the Phantom Thieves by night in this stylish JRPG. Change hearts and confront inner demons.	1	Intermediate	8
43	The Witcher 3: Wild Hunt	Embark on a vast open-world adventure as Geralt of Rivia. Hunt monsters, make choices, and shape your own destiny.	1	Advanced	8
44	Uncharted 4: A Thiefs End	Join Nathan Drake on his final adventure as he seeks hidden treasure and faces danger around the world.	1	Intermediate	8
53	Ori and the Will of the Wisps	Embark on an enchanting adventure as Ori in this visually stunning platformer. Uncover the mysteries of the forest and restore its balance.	1	Intermediate	6
54	Yakuza: Like a Dragon	Step into the shoes of Ichiban Kasuga and experience the dramatic world of the Yakuza. This RPG brings a new combat system to the series.	1	Intermediate	6
55	Celeste	Guide Madeline on a challenging ascent of Celeste Mountain. Overcome personal demons and master difficult platforming levels.	1	Advanced	6
56	Dead Cells	Enter a punishing roguelike metroidvania game. Explore a constantly changing castle, battle tough enemies, and uncover secrets.	1	Advanced	6
57	The Artful Escape	Embark on a cosmic journey as Francis Vendetti, a teenage guitar prodigy. Explore vibrant landscapes and create your own music.	1	Intermediate	6
58	Sekiro: Shadows Die Twice	Master the way of the shinobi as Wolf. Engage in intense sword battles and explore a reimagined late 1500s Sengoku period Japan.	1	Advanced	6
59	The Outer Worlds	Navigate a satirical and alternate future where corporations have colonized space. Make choices that impact the outcome of the story.	1	Intermediate	6
\.


--
-- Data for Name: gaming_consoles; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.gaming_consoles (console_id, name, manufacturer) FROM stdin;
4	PlayStation 5	Sony
5	Xbox Series X	Microsoft
6	Xbox Series S	Microsoft
7	Nintendo Switch	Nintendo
8	PlayStation 4	Sony
\.


--
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.recommendation (recommendation_id, user_id, game_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: reuben
--

COPY public.users (user_id, username, password) FROM stdin;
1	user1	\N
3	reuben	sha256$YJBShMMliMQiSmiz$11c065677a7d1afbb886ed28fc077f9817239f0514cc50b3dbee8ee24eecab41
4	Harry	sha256$3JAn1gvbfAM72Apj$e3ef49ef61394b8f45b321c4542025aa79f861c16d6da3b3f217e02220f1855d
5	testuser	sha256$tQHMfF2Jlgt4EnHj$0dc5f8b9c76475298ae8ca613fe23d47c450c558aabc7b50f7342f479616638c
6	reuben2	sha256$oqHa1G0UPQZOjEgR$2699984e17428726e677785d8cb5a5d18f4e793759c19c2b1032c6f41d293bce
\.


--
-- Name: board_game_boardgame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.board_game_boardgame_id_seq', 23, true);


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.comments_comment_id_seq', 3, true);


--
-- Name: console_games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.console_games_game_id_seq', 59, true);


--
-- Name: gaming_consoles_console_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.gaming_consoles_console_id_seq', 8, true);


--
-- Name: recommendation_recommendation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.recommendation_recommendation_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: reuben
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: board_game board_game_description_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT board_game_description_key UNIQUE (description);


--
-- Name: board_game board_game_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT board_game_pkey PRIMARY KEY (boardgame_id);


--
-- Name: board_game board_game_title_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT board_game_title_key UNIQUE (title);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: console_games console_games_description_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.console_games
    ADD CONSTRAINT console_games_description_key UNIQUE (description);


--
-- Name: console_games console_games_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.console_games
    ADD CONSTRAINT console_games_pkey PRIMARY KEY (game_id);


--
-- Name: console_games console_games_title_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.console_games
    ADD CONSTRAINT console_games_title_key UNIQUE (title);


--
-- Name: gaming_consoles gaming_consoles_name_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.gaming_consoles
    ADD CONSTRAINT gaming_consoles_name_key UNIQUE (name);


--
-- Name: gaming_consoles gaming_consoles_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.gaming_consoles
    ADD CONSTRAINT gaming_consoles_pkey PRIMARY KEY (console_id);


--
-- Name: recommendation recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (recommendation_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: comments comments_boardgame_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_boardgame_id_fkey FOREIGN KEY (board_game_id) REFERENCES public.board_game(boardgame_id);


--
-- Name: comments comments_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_game_id_fkey FOREIGN KEY (console_game_id) REFERENCES public.console_games(game_id);


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: console_games console_games_console_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.console_games
    ADD CONSTRAINT console_games_console_id_fkey FOREIGN KEY (console_id) REFERENCES public.gaming_consoles(console_id);


--
-- Name: recommendation recommendation_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.console_games(game_id);


--
-- Name: recommendation recommendation_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: reuben
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

