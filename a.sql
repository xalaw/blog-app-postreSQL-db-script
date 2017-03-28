
/* Users have first names, last names, email addresses, and screen names. Email addresses and screen names are required.

Each post has a single author (who is a user), a title, content, a published timestamp, zero or more comments, and zero or more tags.

A comment has one author (aka user), one post (the original post the comment is about), and the comment text itself. 

A tag has tag text. For instance "current events".
As a stretch goal, configure comments so they can have a referring comment. In other words, each comment can optionally point to another comment.*/


CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name text,
    last_name text,
    email text NOT NULL,
    screen_name text NOT NULL
);

CREATE TABLE posts (
    id serial PRIMARY KEY,
    title text,
    content text,
    author_id int REFERENCES users ON DELETE RESTRICT,
    published timestamp DEFAULT now()
);

CREATE TABLE comments (
    id serial PRIMARY KEY,
    comment_text text,
    author_id int REFERENCES users ON DELETE CASCADE NOT NULL,
    post_id int REFERENCES posts ON DELETE CASCADE NOT NULL
);



CREATE TABLE tags (
    id serial PRIMARY KEY,
    tag text NOT NULL
);

CREATE TABLE post_tags (
    post_id int REFERENCES posts(id) on DELETE CASCADE,
    tag_id int REFERENCES tags(id) on DELETE RESTRICT,
    PRIMARY KEY (post_id, tag_id)
);


INSERT INTO users (email, screen_name) VALUES
    ('someone@gmail.com', 'Someone'),
    ('somebody@gmail.com', 'Somebody'),
    ('something@gmail.com', 'Something');


INSERT INTO posts (title, content, author_id) VALUES
    ('This is a Title!', 'lorem ipsum', 1 ),
    ('This is another Title!', 'lorem ipsum', 1 );


INSERT INTO tags (tag) VALUES
    ('me'), ('you'), ('stuff');

INSERT INTO post_tags( post_id, tag_id) VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 3);

INSERT INTO comments (author_id, post_id) VALUES
    (1, 1),
    (3, 1);

INSERT INTO comments ( author_id, post_id, referring_comment_id) VALUES
    (1, 1, 1),
    (2, 1, 2);

