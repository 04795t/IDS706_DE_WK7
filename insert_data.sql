-- adding pony data
INSERT INTO ponies VALUES
(1, 'Twilight Sparkle', 'Alicorn', 'Magic', 'Pink star with sparkles', 'Ponyville', 2003),
(2, 'Rainbow Dash', 'Pegasus', 'Loyalty', 'Rainbow lightning bolt', 'Cloudsdale', 2004),
(3, 'Pinkie Pie', 'Earth Pony', 'Laughter', 'Three balloons', 'Ponyville', 2004),
(4, 'Rarity', 'Unicorn', 'Generosity', 'Three diamonds', 'Ponyville', 2003),
(5, 'Fluttershy', 'Pegasus', 'Kindness', 'Three butterflies', 'Ponyville', 2004),
(6, 'Applejack', 'Earth Pony', 'Honesty', 'Three apples', 'Sweet Apple Acres', 2003),
(7, 'Spike', 'Dragon', NULL, 'None', 'Ponyville', 2008),
(8, 'Princess Celestia', 'Alicorn', NULL, 'Sun', 'Canterlot', 1000),
(9, 'Princess Luna', 'Alicorn', NULL, 'Moon', 'Canterlot', 1000),
(10, 'Starlight Glimmer', 'Unicorn', NULL, 'Star with streams', 'Ponyville', 2005);

-- friendship data
INSERT INTO friendships VALUES
(1, 1, 7, '2010-06-01', 10),
(2, 1, 2, '2010-10-10', 9),
(3, 1, 3, '2010-10-10', 9),
(4, 1, 4, '2010-10-10', 9),
(5, 1, 5, '2010-10-10', 9),
(6, 1, 6, '2010-10-10', 9),
(7, 2, 5, '2008-05-15', 10),
(8, 3, 4, '2010-11-20', 8),
(9, 1, 10, '2015-03-26', 8),
(10, 6, 3, '2011-01-15', 7);

-- adventure data
INSERT INTO adventures VALUES
(1, 'Defeat Nightmare Moon', 'Castle of Two Sisters', '2010-10-22', 'Extreme', 1, 6),
(2, 'Discord Chaos', 'Ponyville', '2011-09-17', 'Hard', 1, 6),
(3, 'Crystal Empire Rescue', 'Crystal Empire', '2012-11-10', 'Hard', 1, 4),
(4, 'Tirek Battle', 'Equestria', '2014-05-10', 'Extreme', 1, 6),
(5, 'Starlight Time Travel', 'Cloudsdale', '2015-11-28', 'Extreme', 1, 2),
(6, 'Royal Wedding', 'Canterlot', '2012-04-21', 'Medium', 1, 3),
(7, 'Parasprite Invasion', 'Ponyville', '2010-12-11', 'Easy', 1, 0),
(8, 'Fashion Show Disaster', 'Ponyville', '2011-02-04', 'Easy', 0, 0),
(9, 'Apple Family Reunion', 'Sweet Apple Acres', '2012-12-22', 'Easy', 1, 0),
(10, 'School of Friendship Opening', 'Ponyville', '2017-04-15', 'Medium', 1, 1);

-- who participated in each adventure
INSERT INTO adventure_participants VALUES
(1, 1, 1, 'Leader', 95),
(2, 1, 2, 'Support', 90),
(3, 1, 3, 'Support', 85),
(4, 1, 4, 'Support', 85),
(5, 1, 5, 'Support', 88),
(6, 1, 6, 'Support', 90),
(7, 2, 1, 'Leader', 92),
(8, 2, 5, 'Support', 80),
(9, 3, 1, 'Leader', 88),
(10, 3, 7, 'Support', 85),
(11, 4, 1, 'Leader', 98),
(12, 4, 2, 'Support', 92),
(13, 4, 3, 'Support', 90),
(14, 5, 1, 'Leader', 94),
(15, 5, 7, 'Support', 88),
(16, 5, 10, 'Leader', 96),
(17, 6, 1, 'Support', 85),
(18, 6, 7, 'Support', 78),
(19, 7, 3, 'Leader', 95),
(20, 8, 4, 'Leader', 60),
(21, 9, 6, 'Leader', 92),
(22, 9, 3, 'Support', 88),
(23, 10, 1, 'Leader', 90);

-- talent data
INSERT INTO talents VALUES
(1, 1, 'Magic Mastery', 10, '2010-06-01'),
(2, 1, 'Friendship Magic', 10, '2010-10-22'),
(3, 2, 'Speed Flying', 10, '2008-01-15'),
(4, 2, 'Weather Control', 9, '2009-05-20'),
(5, 3, 'Party Planning', 10, '2007-03-10'),
(6, 3, 'Predicting Future', 7, '2011-06-15'),
(7, 4, 'Fashion Design', 10, '2008-09-12'),
(8, 4, 'Gem Finding', 9, '2009-07-08'),
(9, 5, 'Animal Communication', 10, '2005-11-30'),
(10, 5, 'Nature Magic', 8, '2011-02-18'),
(11, 6, 'Apple Farming', 10, '2006-04-25'),
(12, 6, 'Honesty Detection', 9, '2010-11-05'),
(13, 7, 'Fire Breathing', 8, '2010-08-20'),
(14, 10, 'Time Magic', 9, '2015-03-26'),
(15, 10, 'Equality Spells', 7, '2014-11-15');