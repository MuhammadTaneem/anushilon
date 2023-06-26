

CREATE TABLE "admin" (
    id SERIAL4 PRIMARY KEY,
    full_name VARCHAR,
    password VARCHAR,
    email VARCHAR,
    active BOOLEAN DEFAULT FALSE
);
INSERT INTO "admin" (full_name, password, email, active)
VALUES ('Taneem', '$2b$12$fiHF0j8A/WwIvCjUYaImqudA/zoA3z0IRX40M36VAKXYAX2.Bk0na', 'taneem71@gmail.com.com', TRUE);


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
