-- ============================================
-- Useful Queries for Analysis
-- ============================================

-- Query 1: Survey statistics overview
SELECT 
    COUNT(*) as total_responses,
    SUM(CASE WHEN heard_of_iot = 'Yes' THEN 1 ELSE 0 END) as heard_count,
    ROUND(AVG(familiarity_level), 2) as avg_familiarity,
    ROUND(AVG(importance_rating), 2) as avg_importance,
    ROUND(AVG(usefulness_rating), 2) as avg_usefulness,
    ROUND(AVG(relevance_rating), 2) as avg_relevance,
    ROUND(AVG(future_impact_rating), 2) as avg_future_impact
FROM survey_responses;

-- Query 2: Education level distribution
SELECT 
    education_level,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) as percentage
FROM survey_responses
GROUP BY education_level
ORDER BY count DESC;

-- Query 3: Age group analysis
SELECT 
    age_group,
    COUNT(*) as count,
    AVG(importance_rating) as avg_importance
FROM survey_responses
GROUP BY age_group
ORDER BY age_group;

-- Query 4: Familiarity vs Ratings correlation
SELECT 
    familiarity_level,
    COUNT(*) as count,
    AVG(importance_rating) as avg_importance,
    AVG(usefulness_rating) as avg_usefulness
FROM survey_responses
WHERE familiarity_level IS NOT NULL
GROUP BY familiarity_level
ORDER BY familiarity_level;

-- Query 5: IoT Awareness percentage
SELECT 
    heard_of_iot,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) as percentage
FROM survey_responses
GROUP BY heard_of_iot;

-- Query 6: Most common concerns
SELECT concerns, COUNT(*) as frequency
FROM survey_responses
WHERE concerns IS NOT NULL AND concerns != ''
GROUP BY concerns
ORDER BY frequency DESC;

-- Query 7: References by year
SELECT 
    publication_year,
    COUNT(*) as count
FROM _references
GROUP BY publication_year
ORDER BY publication_year DESC;

-- Query 8: Average ratings by occupation
SELECT 
    occupation,
    COUNT(*) as responses,
    ROUND(AVG(importance_rating), 1) as avg_importance,
    ROUND(AVG(usefulness_rating), 1) as avg_usefulness
FROM survey_responses
GROUP BY occupation;

-- Query 9: Complete survey data export
SELECT 
    response_id,
    age_group,
    education_level,
    occupation,
    heard_of_iot,
    familiarity_level,
    importance_rating,
    usefulness_rating,
    relevance_rating,
    future_impact_rating,
    valuable_applications,
    standout_benefit,
    concerns,
    submitted_at
FROM survey_responses
ORDER BY response_id;

-- Query 10: Team member list
SELECT 
    full_name,
    registration_number,
    _role,
    contribution_areas
FROM team_members
ORDER BY full_name;

-- Query 11: All references formatted
SELECT 
    title,
    authors,
    publication_year,
    ieee_citation
FROM _references
ORDER BY publication_year DESC, authors;