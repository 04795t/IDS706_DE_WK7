-- my little pony pony database tables

-- table for pony characters
CREATE TABLE ponies (
    pony_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    pony_type VARCHAR(20) NOT NULL,
    element VARCHAR(30),
    cutie_mark VARCHAR(100),
    home_location VARCHAR(50),
    birth_year INTEGER
);

-- table for friendships
CREATE TABLE friendships (
    friendship_id INTEGER PRIMARY KEY,
    pony_id_1 INTEGER,
    pony_id_2 INTEGER,
    friendship_date DATE,
    friendship_strength INTEGER,
    FOREIGN KEY (pony_id_1) REFERENCES ponies(pony_id),
    FOREIGN KEY (pony_id_2) REFERENCES ponies(pony_id)
);

-- table for adventures
CREATE TABLE adventures (
    adventure_id INTEGER PRIMARY KEY,
    adventure_name VARCHAR(100) NOT NULL,
    location VARCHAR(50),
    adventure_date DATE,
    difficulty_level VARCHAR(20),
    success BOOLEAN,
    magical_elements_used INTEGER
);

-- table connecting ponies to adventures
CREATE TABLE adventure_participants (
    participation_id INTEGER PRIMARY KEY,
    adventure_id INTEGER,
    pony_id INTEGER,
    role VARCHAR(30),
    contribution_score INTEGER,
    FOREIGN KEY (adventure_id) REFERENCES adventures(adventure_id),
    FOREIGN KEY (pony_id) REFERENCES ponies(pony_id)
);

-- table for pony talents
CREATE TABLE talents (
    talent_id INTEGER PRIMARY KEY,
    pony_id INTEGER,
    talent_name VARCHAR(50),
    skill_level INTEGER,
    acquired_date DATE,
    FOREIGN KEY (pony_id) REFERENCES ponies(pony_id)
);