--- 1. Get a list of all film languages.

SELECT f.title, l.name
FROM film f
    LEFT JOIN language l ON f.language_id = l.language_id;


--- 2. /* Get a list of all films joined with their languages – select the following details :
-- film title, description, and language name. Try your query with different joins:

Get all films, even if they don’t have languages.
Get all languages, even if there are no films in those languages.*/

SELECT f.title, l.name
FROM film f
    RIGHT JOIN language l ON f.language_id = l.language_id;

SELECT
    f.title,
    f.description,
    l.name
FROM film f
    LEFT JOIN language l ON f.language_id = l.language_id;

SELECT
    f.title,
    f.description,
    l.name
FROM language l
    LEFT JOIN film f ON f.language_id = l.language_id;

--- 3. Create a new table called new_film with the following columns : id,
-- name. Add some new films to the table.

--- A.

CREATE TABLE
    new_film(
        lg_nwfid SERIAL PRIMARY KEY,
        str_nwfname VARCHAR(100)
    );

--- B.

INSERT INTO
    new_film(str_nwfname)
VALUES ('il etait une fois en chine'), ('la soupe au choud'), ('ducobus'), ('obelix et asterix');

--- 4.
/* 
Create a new table called customer_review, which will contain film reviews that customers will make.
Think about the DELETE constraint: if a film is deleted, its review should be automatically deleted.
It should have the following columns:
review_id – a primary key, non null, auto-increment.
film_id – references the new_film table. The film that is being reviewed.
language_id – references the language table. What language the review is in.
title – the title of the review.
score – the rating of the review (1-10).
review_text – the text of the review. No limit on the length.
last_update – when the review was last updated.

 */

CREATE TABLE
    customer_review(
        lg_curid SERIAL,
        title VARCHAR(100),
        score SMALLINT,
        review_text VARCHAR,
        last_update TIMESTAMP,
        PRIMARY KEY(lg_curid),
        fk_lg_nwfid INTEGER REFERENCES new_film (lg_nwfid) ON DELETE CASCADE,
        fk_language_id INTEGER REFERENCES language(language_id) ON DELETE CASCADE
    );

--- 5. Add 2 movie reviews. Make sure you link them to valid objects in the other tables.

INSERT INTO
    customer_review(
        title,
        score,
        review_text,
        last_update,
        fk_lg_nwfid,
        fk_language_id
    )
VALUES (
        'mon opinion est :mouhamed',
        8,
        'RSA',
        current_timestamp,
        1,
        1
    ), (
        'mon opinion est :coulibaly',
        9,
        'tres bon',
        current_timestamp,
        2,
        2
    );

SELECT * FROM customer_review;

SELECT * FROM new_film;

--Delete a film that has a review from the new_film table,
-- what happens to the customer_review table?

DELETE FROM new_film WHERE lg_nwfid = 2;
