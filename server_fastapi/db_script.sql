

CREATE TABLE "admin" (
    id SERIAL4 PRIMARY KEY,
    full_name VARCHAR,
    role VARCHAR,
    password VARCHAR,
    email VARCHAR,
    active BOOLEAN DEFAULT FALSE
);
INSERT INTO "admin" (full_name, password, email, active)
VALUES ('Taneem', '$2b$12$fiHF0j8A/WwIvCjUYaImqudA/zoA3z0IRX40M36VAKXYAX2.Bk0na', 'taneem71@gmail.com.com', TRUE);



CREATE TABLE mcq (
    id SERIAL4 PRIMARY KEY,
    question VARCHAR,
    question_img_url VARCHAR,
    option_text_1 VARCHAR,
    option_img_url_1 VARCHAR,
    option_text_2 VARCHAR,
    option_img_url_2 VARCHAR,
    option_text_3 VARCHAR,
    option_img_url_3 VARCHAR,
    option_text_4 VARCHAR,
    option_img_url_4 VARCHAR,
    correct_ans VARCHAR NOT NULL,
    explanation VARCHAR,
    explanation_img VARCHAR,
    hardness VARCHAR NOT NULL,
    categories VARCHAR NOT NULL,
    subject INTEGER NOT NULL,
    chapter INTEGER NOT NULL,
    problem_setter INTEGER,
    verified BOOLEAN DEFAULT FALSE,
    published BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (problem_setter) REFERENCES admin(id),
    create_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_edit TIMESTAMP WITH TIME ZONE
);




--
-- CREATE TABLE "page" (
--     id SERIAL4 PRIMARY KEY,
--     author INTEGER REFERENCES "user" (id) ON DELETE CASCADE,
--     parent_page_id INTEGER DEFAULT 0,
--     page_name VARCHAR DEFAULT 'Unnamed',
--     page_description VARCHAR,
--     color VARCHAR,
--     create_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
--     last_edit TIMESTAMP WITH TIME ZONE DEFAULT now()
-- );
--
-- CREATE TABLE task (
--     id SERIAL PRIMARY KEY,
--     author INTEGER REFERENCES "user" (id) ON DELETE CASCADE,
--     page_id INTEGER REFERENCES page (id) ON DELETE CASCADE,
--     task_name VARCHAR DEFAULT 'Unnamed',
--     task_description VARCHAR,
--     status VARCHAR,
--     create_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
--     last_edit TIMESTAMP WITH TIME ZONE
-- );


