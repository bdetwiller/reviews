CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(30) NOT NULL,
  lname VARCHAR(30) NOT NULL,
  mentor INTEGER
);

CREATE TABLE restaurants (
	id INTEGER PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	neighborhood VARCHAR(200) NOT NULL,
	cusine VARCHAR(40) NOT NULL
);

CREATE TABLE chef_tenure (
	id INTEGER PRIMARY KEY,
	restaurant_id INTEGER NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	head_chef INTEGER NOT NULL,
	chef_id INTEGER NOT NULL
);

CREATE TABLE critics (
	id INTEGER PRIMARY KEY,
	screen_name VARCHAR(30) NOT NULL
);

CREATE TABLE reviews (
	id INTEGER PRIMARY KEY,
	critic_id VARCHAR(30) NOT NULL,
	restaurant_id INTEGER NOT NULL,
	text_review VARCHAR(250) NOT NULL,
	score INTEGER NOT NULL,
	review_date DATE
);

INSERT INTO chefs ('fname','lname','mentor')
VALUES ('Bryant', 'Detwiller', 3), ('Eric', 'Lin', 1), ('Misha', 'Yerlick', NULL);

INSERT INTO restaurants ('name', 'neighborhood', 'cusine')
VALUES ('Delfina', 'Mission', 'American'), ('Zero Zero', 'SOMA', 'Pizza'),
('Yamo', 'Mission', 'Burmese'), ('Tacqueria Cancun', 'Mission', 'Mexican');

INSERT INTO chef_tenure ('restaurant_id', 'start_date', 'end_date', 'head_chef', 'chef_id')
VALUES (1, '2012-12-15', '2013-03-29', 0, 2), (3, '2010-10-15', '2013-02-15', 1, 3),
(3, '2010-05-15', '2011-11-29', 0, 1), (4, '2011-12-15', '2013-01-29', 1, 1), (3, '2012-05-15', '2013-03-25', 0 , 2);

INSERT INTO critics ('screen_name')
VALUES ('i_love_eating'), ('Eric2040'), ('SFliving02'), ('Zagat');

INSERT INTO reviews ('critic_id', 'restaurant_id', 'text_review', 'score', 'review_date')
VALUES (1, 4, 'This place is ok but the chef is awesome', 3, '2012-12-15'),
(4, 2, 'Neapolitan pizzas are “so in vogue” and this “swanky” SoMa Italian stands out', 2, '2013-01-15'),
(2, 4, 'Best burritos in town, hands down', 4, '2012-04-04');


