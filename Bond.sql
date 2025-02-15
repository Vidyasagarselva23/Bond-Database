-- Create the Table:



CREATE TABLE bond (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    released INT,
    actor VARCHAR(50),
    director VARCHAR(50),
    box_office DECIMAL(10,2)
);

-- PostgreSQL does not support SHOW TABLES or DESCRIBE.
-- Instead, use:
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- Get table structure:
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'bond';

-- Insert Data:

INSERT INTO bond (id, title, released, actor, director, box_office) VALUES
(1, 'Dr. No', 1962, 'Sean Connery', 'Terence Young', 59.5),
(2, 'From Russia with Love', 1963, 'Sean Connery', 'Terence Young', 78.9),
(3, 'Goldfinger', 1964, 'Sean Connery', 'Guy Hamilton', 124.9),
(4, 'Thunderball', 1965, 'Sean Connery', 'Terence Young', 141.2),
(5, 'You Only Live Twice', 1967, 'Sean Connery', 'Lewis Gilbert', 111.6),
(6, 'On Her Majesty''s Secret Service', 1969, 'George Lazenby', 'Peter R. Hunt', 64.6),
(7, 'Diamonds Are Forever', 1971, 'Sean Connery', 'Guy Hamilton', 116),
(8, 'Live and Let Die', 1973, 'Roger Moore', 'Guy Hamilton', 126.4),
(9, 'The Man with the Golden Gun', 1974, 'Roger Moore', 'Guy Hamilton', 97.6),
(10, 'The Spy Who Loved Me', 1977, 'Roger Moore', 'Lewis Gilbert', 185.4),
(11, 'Moonraker', 1979, 'Roger Moore', 'Lewis Gilbert', 210.3),
(12, 'For Your Eyes Only', 1981, 'Roger Moore', 'John Glen', 194.9),
(13, 'Octopussy', 1983, 'Roger Moore', 'John Glen', 183.7),
(14, 'Never Say Never Again', 1983, 'Sean Connery', 'Irvin Kershner', 160.0),
(15, 'A View to a Kill', 1985, 'Roger Moore', 'John Glen', 152.4),
(16, 'The Living Daylights', 1987, 'Timothy Dalton', 'John Glen', 191.2),
(17, 'Licence to Kill', 1989, 'Timothy Dalton', 'John Glen', 156.2),
(18, 'GoldenEye', 1995, 'Pierce Brosnan', 'Martin Campbell', 352),
(19, 'Tomorrow Never Dies', 1997, 'Pierce Brosnan', 'Roger Spottiswoode', 333),
(20, 'The World Is Not Enough', 1999, 'Pierce Brosnan', 'Michael Apted', 361.8),
(21, 'Die Another Day', 2002, 'Pierce Brosnan', 'Lee Tamahori', 432),
(22, 'Casino Royale', 2006, 'Daniel Craig', 'Martin Campbell', 606),
(23, 'Quantum of Solace', 2008, 'Daniel Craig', 'Marc Forster', 586.1),
(24, 'Skyfall', 2012, 'Daniel Craig', 'Sam Mendes', 1108.6),
(25, 'Spectre', 2015, 'Daniel Craig', 'Sam Mendes', 880.7),
(26, 'No Time to Die', 2021, 'Daniel Craig', 'Cary Joji Fukunaga', NULL);

-- Basic Queries:

-- Retrieve all data:
SELECT * FROM bond;

-- Retrieve specific columns:
SELECT title, actor, released FROM bond;

-- Sort by box office earnings (highest to lowest):
SELECT * FROM bond
ORDER BY box_office DESC;

-- Filter movies released after 2000:
SELECT * FROM bond
WHERE released > 2000;

-- Aggregation and Grouping:

-- Total box office revenue:
SELECT SUM(box_office) AS total_revenue FROM bond;

-- Average box office earnings:
SELECT AVG(box_office) AS avg_revenue FROM bond;

-- Count movies by actor:
SELECT actor, COUNT(*) AS movie_count
FROM bond
GROUP BY actor;

-- Maximum and minimum box office earnings:
SELECT MAX(box_office) AS highest_earning, MIN(box_office) AS lowest_earning FROM bond;

-- Conditional Queries:

-- Movies with box office earnings greater than $200M:
SELECT title, box_office FROM bond
WHERE box_office > 200;

-- Movies by Sean Connery:
SELECT * FROM bond
WHERE actor = 'Sean Connery';

-- Movies not directed by Guy Hamilton:
SELECT * FROM bond
WHERE director != 'Guy Hamilton';

-- Movies released between 1980 and 2000:
SELECT * FROM bond
WHERE released BETWEEN 1980 AND 2000;

-- Joins (if you add another table):

-- Create a franchise table:
CREATE TABLE franchise (
    movie_id INT,
    franchise_name VARCHAR(50),
    FOREIGN KEY (movie_id) REFERENCES bond(id)
);

INSERT INTO franchise (movie_id, franchise_name)
VALUES
    (1, 'James Bond'),
    (2, 'James Bond'),
    (24, 'James Bond');

-- Inner Join with Franchise Table:
SELECT bond.title, bond.actor, franchise.franchise_name
FROM bond
INNER JOIN franchise ON bond.id = franchise.movie_id;

-- Advanced Queries:

-- Find the actor with the most appearances:
SELECT actor, COUNT(*) AS appearances
FROM bond
GROUP BY actor
ORDER BY appearances DESC
LIMIT 1;

-- Cumulative box office earnings by actor:
SELECT actor, SUM(box_office) AS total_revenue
FROM bond
GROUP BY actor
ORDER BY total_revenue DESC;

-- Top 5 highest-grossing movies:
SELECT title, box_office
FROM bond
ORDER BY box_office DESC
LIMIT 5;

-- Views:

-- Create a view for all Roger Moore movies:
CREATE VIEW roger_moore_movies AS
SELECT * FROM bond
WHERE actor = 'Roger Moore';

-- Query the view:
SELECT * FROM roger_moore_movies;

-- Indexes:

-- Create an index for faster actor lookups:
CREATE INDEX idx_actor ON bond(actor);

-- Subqueries:

-- Find movies with above-average box office earnings:
SELECT * FROM bond
WHERE box_office > (SELECT AVG(box_office) FROM bond);

-- Data Modification:

-- Update a movie's box office earnings:
UPDATE bond
SET box_office = 900.0
WHERE title = 'Spectre';

-- Delete movies with box office earnings below $100M:
DELETE FROM bond
WHERE box_office < 100;

-- Useful Functions:

-- Concatenate actor and director names:
SELECT actor || ' - ' || director AS actor_director
FROM bond;

-- Extract the year from a release date (if you use DATE type for released):
-- Note: This will work only if 'released' is stored as a DATE, not INT.
-- If released is an INT, this query is unnecessary.
SELECT EXTRACT(YEAR FROM released::DATE) AS release_year
FROM bond;

-- Backup and Export:

-- PostgreSQL does not support `INTO OUTFILE` like MySQL.
-- Use the COPY command instead:
select * from public."bond"


COPY public.bond TO 'C:/Temp/bond.csv' DELIMITER ',' CSV HEADER;








