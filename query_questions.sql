-- 1. Who are all the Alicorn ponies, ordered by birth year?
-- basic query with WHERE and ORDER BY
SELECT name, pony_type, element, birth_year
FROM ponies
WHERE pony_type = 'Alicorn'
ORDER BY birth_year ASC;

-- 2. What are the statistics for each pony type?
-- using COUNT, AVG, MIN with GROUP BY
SELECT
    pony_type,
    COUNT(*) as total_ponies,
    ROUND(AVG(birth_year), 0) as avg_birth_year,
    MIN(birth_year) as oldest_birth_year
FROM ponies
GROUP BY pony_type
ORDER BY total_ponies DESC;

-- 3. Which ponies have more than 1 talent and what's their average skill level?
-- needs HAVING instead of WHERE because filtering on COUNT
SELECT
    p.name,
    COUNT(t.talent_id) as talent_count,
    ROUND(AVG(t.skill_level), 1) as avg_skill_level
FROM ponies p
INNER JOIN talents t ON p.pony_id = t.pony_id
GROUP BY p.pony_id, p.name
HAVING COUNT(t.talent_id) > 1
ORDER BY talent_count DESC;

-- 4. What are all the friendship connections between ponies?
-- need to join ponies table twice here for both sides of the friendship
SELECT
    p1.name as pony_1,
    p2.name as pony_2,
    f.friendship_date,
    f.friendship_strength
FROM friendships f
INNER JOIN ponies p1 ON f.pony_id_1 = p1.pony_id
INNER JOIN ponies p2 ON f.pony_id_2 = p2.pony_id
ORDER BY f.friendship_strength DESC;

-- 5. Show all ponies and their adventure counts, including those who never went on adventures
-- LEFT JOIN keeps all ponies even if they have no adventures
SELECT
    p.name,
    p.pony_type,
    COUNT(ap.adventure_id) as adventures_count,
    ROUND(AVG(ap.contribution_score), 1) as avg_contribution
FROM ponies p
LEFT JOIN adventure_participants ap ON p.pony_id = ap.pony_id
GROUP BY p.pony_id, p.name, p.pony_type
ORDER BY adventures_count DESC;

-- 6. Which adventures did ponies with the "Magic" element participate in?
-- joining 3 tables together
SELECT
    a.adventure_name,
    a.adventure_date,
    p.name as pony_name,
    ap.role,
    ap.contribution_score
FROM adventures a
INNER JOIN adventure_participants ap ON a.adventure_id = ap.adventure_id
INNER JOIN ponies p ON ap.pony_id = p.pony_id
WHERE p.element = 'Magic'
ORDER BY a.adventure_date;

-- 7. How can we categorize ponies by age groups and ability types?
-- CASE WHEN creates categories based on conditions
SELECT
    name,
    birth_year,
    CASE
        WHEN birth_year < 2000 THEN 'Ancient'
        WHEN birth_year BETWEEN 2000 AND 2003 THEN 'Experienced'
        WHEN birth_year BETWEEN 2004 AND 2006 THEN 'Young Adult'
        ELSE 'Young'
    END as age_category,
    CASE
        WHEN pony_type IN ('Alicorn', 'Unicorn') THEN 'Magical'
        WHEN pony_type = 'Pegasus' THEN 'Flying'
        ELSE 'Grounded'
    END as ability_type
FROM ponies
ORDER BY birth_year;

-- 8. How do ponies rank based on their adventure performance?
-- window functions let you rank without grouping issues
SELECT
    p.name,
    COUNT(ap.adventure_id) as total_adventures,
    ROUND(AVG(ap.contribution_score), 1) as avg_contribution,
    ROW_NUMBER() OVER (ORDER BY AVG(ap.contribution_score) DESC) as row_num,
    RANK() OVER (ORDER BY AVG(ap.contribution_score) DESC) as rank_position
FROM ponies p
INNER JOIN adventure_participants ap ON p.pony_id = ap.pony_id
GROUP BY p.pony_id, p.name
ORDER BY avg_contribution DESC;

-- 9. What's the success rate for adventures at each difficulty level?
-- PARTITION BY calculates stats within each difficulty group
SELECT
    difficulty_level,
    adventure_name,
    success,
    COUNT(*) OVER (PARTITION BY difficulty_level) as total_in_difficulty,
    ROUND(100.0 * SUM(CASE WHEN success THEN 1 ELSE 0 END)
        OVER (PARTITION BY difficulty_level) /
        COUNT(*) OVER (PARTITION BY difficulty_level), 1) as success_rate
FROM adventures
ORDER BY difficulty_level, adventure_date;

-- 10. Which ponies have above-average talent skill levels?
-- WITH makes complex queries easier to read
WITH talent_averages AS (
    SELECT
        p.pony_id,
        p.name,
        AVG(t.skill_level) as avg_skill
    FROM ponies p
    INNER JOIN talents t ON p.pony_id = t.pony_id
    GROUP BY p.pony_id, p.name
)
SELECT
    name,
    ROUND(avg_skill, 1) as avg_talent_level
FROM talent_averages
WHERE avg_skill > (SELECT AVG(skill_level) FROM talents)
ORDER BY avg_skill DESC;

-- 11. What are the comprehensive friendship and adventure statistics for each pony?
-- using multiple CTEs to break down the problem
WITH friendship_stats AS (
    SELECT
        pony_id_1 as pony_id,
        COUNT(*) as friend_count
    FROM friendships
    GROUP BY pony_id_1
),
adventure_stats AS (
    SELECT
        pony_id,
        COUNT(DISTINCT adventure_id) as adventure_count
    FROM adventure_participants
    GROUP BY pony_id
)
SELECT
    p.name,
    COALESCE(fs.friend_count, 0) as friends,
    COALESCE(as2.adventure_count, 0) as adventures
FROM ponies p
LEFT JOIN friendship_stats fs ON p.pony_id = fs.pony_id
LEFT JOIN adventure_stats as2 ON p.pony_id = as2.pony_id
ORDER BY friends DESC, adventures DESC;

-- 12. How can we format and manipulate pony profile information?
-- string functions I looked up: UPPER, ||, LENGTH, SUBSTR, LIKE
SELECT
    UPPER(name) as name_caps,
    name || ' the ' || pony_type as full_title,
    LENGTH(cutie_mark) as cutie_mark_length,
    SUBSTR(home_location, 1, 4) as location_code
FROM ponies
WHERE name LIKE '%Twilight%' OR name LIKE '%Rainbow%';

-- 13. Who are the extreme adventurers vs casual adventurers?
-- UNION combines two separate queries into one result
SELECT DISTINCT p.name, 'Extreme Adventurer' as category
FROM ponies p
INNER JOIN adventure_participants ap ON p.pony_id = ap.pony_id
INNER JOIN adventures a ON ap.adventure_id = a.adventure_id
WHERE a.difficulty_level = 'Extreme'

UNION

SELECT DISTINCT p.name, 'Casual Adventurer' as category
FROM ponies p
INNER JOIN adventure_participants ap ON p.pony_id = ap.pony_id
INNER JOIN adventures a ON ap.adventure_id = a.adventure_id
WHERE a.difficulty_level = 'Easy'
ORDER BY category, name;

-- 14. What's a complete report of all ponies with their elements and adventure participation?
-- COALESCE replaces NULL with a default value
SELECT
    p.name,
    COALESCE(p.element, 'No Element') as element,
    COALESCE(COUNT(DISTINCT ap.adventure_id), 0) as adventure_count
FROM ponies p
LEFT JOIN adventure_participants ap ON p.pony_id = ap.pony_id
GROUP BY p.pony_id, p.name, p.element
ORDER BY adventure_count DESC;