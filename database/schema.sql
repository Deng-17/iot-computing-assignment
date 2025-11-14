-- ============================================
-- IoT Computing Project Database Schema
-- SQLite Version
-- Group 2 Day - Kyambogo University
-- ============================================

-- ============================================
-- Table 1: Survey Responses (Updated with actual questions)
-- ============================================
CREATE TABLE IF NOT EXISTS survey_responses (
    response_id INTEGER PRIMARY KEY AUTOINCREMENT,
    
    -- Demographics
    age_group TEXT NOT NULL CHECK(age_group IN ('Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65+')),
    education_level TEXT NOT NULL CHECK(education_level IN ('High School or below', 'College', "Bachelor's degree", "Master's degree or higher", 'Prefer not to say')),
    occupation TEXT NOT NULL CHECK(occupation IN ('Student', 'Employed in tech/IT', 'Employed in non-tech', 'Self-employed', 'Unemployed', 'Retired', 'Other')),
    
    -- IoT Awareness
    heard_of_iot TEXT NOT NULL CHECK(heard_of_iot IN ('Yes', 'No')),
    familiarity_level INTEGER CHECK(familiarity_level BETWEEN 1 AND 4), -- NULL if heard_of_iot = 'No'
    
    -- Ratings (1-5 scale)
    importance_rating INTEGER CHECK(importance_rating BETWEEN 1 AND 5),
    usefulness_rating INTEGER CHECK(usefulness_rating BETWEEN 1 AND 5),
    relevance_rating INTEGER CHECK(relevance_rating BETWEEN 1 AND 5),
    future_impact_rating INTEGER CHECK(future_impact_rating BETWEEN 1 AND 5),
    
    -- Open-ended responses
    valuable_applications TEXT NOT NULL CHECK(valuable_applications IN ("Smart home devices", "Wearable health trackers", "Smart city traffic", "Industrial automation", "Agriculture sensors", "None", "Other")), -- Comma-separated or single value
    standout_benefit TEXT,
    concerns TEXT,
    
    -- Metadata
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table 2: Research References
-- ============================================
CREATE TABLE IF NOT EXISTS _references (
    reference_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    authors TEXT NOT NULL,
    publication_year INTEGER NOT NULL,
    source_type TEXT NOT NULL CHECK(source_type IN ('Journal', 'Book', 'Website', 'Conference Paper', 'Article', 'Technical Report')),
    publisher TEXT,
    _url TEXT,
    doi TEXT,
    ieee_citation TEXT NOT NULL,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);

-- ============================================
-- Table 3: Team Members
-- ============================================
CREATE TABLE IF NOT EXISTS team_members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    registration_number TEXT UNIQUE NOT NULL,
    _role TEXT,
    email TEXT,
    github_username TEXT,
    contribution_areas TEXT,
    joined_date DATE DEFAULT (date('now'))
);

-- ============================================
-- Sample Data Insertion
-- ============================================

-- Sample survey responses
INSERT INTO survey_responses (
    age_group, education_level, occupation, heard_of_iot, familiarity_level,
    importance_rating, usefulness_rating, relevance_rating, future_impact_rating,
    valuable_applications, standout_benefit, concerns
) VALUES 
(
    '18-24', 
    "Bachelor's degree", 
    'Student', 
    'Yes', 
    3,
    5, 
    5, 
    5, 
    5,
    'Wearable health trackers, Smart home devices, Industrial automation',
    'Real-time monitoring and data collection improves decision making',
    'Privacy issues and data security vulnerabilities'
),
(
    '25-34',
    "Master's degree",
    'Employed in tech/IT',
    'Yes',
    4,
    5,
    4,
    5,
    4,
    'Smart city traffic, Industrial automation, Wearable health trackers',
    'Automation and efficiency improvements in various sectors',
    'High implementation costs and interoperability challenges'
),
(
    '35-44',
    "Bachelor's degree",
    'Employed in non-tech',
    'Somewhat',
    2,
    4,
    4,
    4,
    4,
    'Wearable health trackers',
    'Improved patient care through continuous monitoring',
    'Device reliability and patient data privacy'
),
(
    '18-24',
    'College',
    'Employed in non-tech',
    'No',
    NULL,
    3,
    3,
    3,
    3,
    'Not sure',
    'Unsure of specific benefits',
    'Lack of awareness and understanding'
),
(
    '45-54',
    'High School or below',
    'Self-employed',
    'Yes',
    2,
    4,
    5,
    4,
    5,
    'Industrial automation, Smart city traffic',
    'Improved business efficiency and cost savings',
    'Technical complexity and maintenance requirements'
);

-- Sample references
INSERT INTO _references (title, authors, publication_year, source_type, publisher, ieee_citation) VALUES
(
    'Internet of Things: A Survey on Enabling Technologies, Protocols, and Applications',
    'A. Al-Fuqaha, M. Guizani, M. Mohammadi, M. Aledhari, and M. Ayyash',
    2015,
    'Journal',
    'IEEE Communications Surveys & Tutorials',
    'A. Al-Fuqaha, M. Guizani, M. Mohammadi, M. Aledhari, and M. Ayyash, "Internet of Things: A Survey on Enabling Technologies, Protocols, and Applications," IEEE Commun. Surveys Tuts., vol. 17, no. 4, pp. 2347-2376, Fourthquarter 2015.'
),
(
    'The Internet of Things for Health Care: A Comprehensive Survey',
    'S. M. R. Islam, D. Kwak, M. H. Kabir, M. Hossain, and K. S. Kwak',
    2015,
    'Journal',
    'IEEE Access',
    'S. M. R. Islam, D. Kwak, M. H. Kabir, M. Hossain, and K. S. Kwak, "The Internet of Things for Health Care: A Comprehensive Survey," IEEE Access, vol. 3, pp. 678-708, 2015.'
),
(
    'IoT Security: Review, Blockchain Solutions, and Open Challenges',
    'M. A. Khan and K. Salah',
    2018,
    'Journal',
    'Future Generation Computer Systems',
    'M. A. Khan and K. Salah, "IoT Security: Review, Blockchain Solutions, and Open Challenges," Future Gener. Comput. Syst., vol. 82, pp. 395-411, May 2018.'
);

-- Sample team members (REPLACE WITH YOUR ACTUAL DATA)
INSERT INTO team_members (full_name, registration_number, _role, email, github_username, contribution_areas) VALUES
('Deng Yak Deng Ater', '25/X/BIO/01367/PD', 'Group Lead, Database & Web Dev', 'dengater17@gmail.com', 'Deng-17', 'Database design, website development, GitHub management'),
('[Your Name 2]', '[REG002]', 'Report Coordinator', '[email2@example.com]', '[github2]', 'Report writing, literature review, formatting'),
('[Your Name 3]', '[REG003]', 'Researcher & Data Analyst', '[email3@example.com]', '[github3]', 'Research, survey design, data analysis, Excel charts'),
('[Your Name 4]', '[REG004]', 'Media & Presentation', '[email4@example.com]', '[github4]', 'Video editing, poster design, presentation slides, graphics');
('[Your Name 5]', '[REG005]', 'Quality Assurance', '[email5@example.com]', '[github5]', 'Testing, proofreading, final review'),

-- ============================================
-- Useful Queries for Analysis
-- ============================================

-- Query 1: Survey statistics overview
-- SELECT 
--     COUNT(*) as total_responses,
--     SUM(CASE WHEN heard_of_iot = 'Yes' THEN 1 ELSE 0 END) as heard_count,
--     ROUND(AVG(familiarity_level), 2) as avg_familiarity,
--     ROUND(AVG(importance_rating), 2) as avg_importance,
--     ROUND(AVG(usefulness_rating), 2) as avg_usefulness,
--     ROUND(AVG(relevance_rating), 2) as avg_relevance,
--     ROUND(AVG(future_impact_rating), 2) as avg_future_impact
-- FROM survey_responses;

-- Query 2: Education level distribution
-- SELECT 
--     education_level,
--     COUNT(*) as count,
--     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) as percentage
-- FROM survey_responses
-- GROUP BY education_level
-- ORDER BY count DESC;

-- Query 3: Age group analysis
-- SELECT 
--     age_group,
--     COUNT(*) as count,
--     AVG(importance_rating) as avg_importance
-- FROM survey_responses
-- GROUP BY age_group
-- ORDER BY age_group;

-- Query 4: Familiarity vs Ratings correlation
-- SELECT 
--     familiarity_level,
--     COUNT(*) as count,
--     AVG(importance_rating) as avg_importance,
--     AVG(usefulness_rating) as avg_usefulness
-- FROM survey_responses
-- WHERE familiarity_level IS NOT NULL
-- GROUP BY familiarity_level
-- ORDER BY familiarity_level;

-- Query 5: Most common concerns (for text analysis)
-- SELECT concerns
-- FROM survey_responses
-- WHERE concerns IS NOT NULL AND concerns != '';

-- Query 6: Applications by category count
-- SELECT 
--     category,
--     COUNT(*) as application_count
-- FROM iot_applications
-- GROUP BY category
-- ORDER BY application_count DESC;