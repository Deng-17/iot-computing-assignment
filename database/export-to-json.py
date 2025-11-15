#!/usr/bin/env python3
# export-to-json.py
import sqlite3
import json
import os

# Create data directory if it doesn't exist
output_dir = '../website/data'
os.makedirs(output_dir, exist_ok=True)

# Connect to database
conn = sqlite3.connect('iot_comp_assignment.db')
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

print("📊 Exporting database to JSON files...")

# ============================================
# Export 1: Survey Statistics
# ============================================
cursor.execute("""
    SELECT 
        COUNT(*) as total_responses,
        SUM(CASE WHEN heard_of_iot = 'Yes' THEN 1 ELSE 0 END) as heard_count,
        SUM(CASE WHEN heard_of_iot = 'No' THEN 1 ELSE 0 END) as not_heard_count,
        SUM(CASE WHEN heard_of_iot = 'Somewhat' THEN 1 ELSE 0 END) as somewhat_count,
        ROUND(AVG(familiarity_level), 2) as avg_familiarity,
        ROUND(AVG(importance_rating), 2) as avg_importance,
        ROUND(AVG(usefulness_rating), 2) as avg_usefulness,
        ROUND(AVG(relevance_rating), 2) as avg_relevance,
        ROUND(AVG(future_impact_rating), 2) as avg_future_impact
    FROM survey_responses
""")
stats = dict(cursor.fetchone())

# Calculate percentages
stats['awareness_percentage'] = round((stats['heard_count'] / stats['total_responses']) * 100, 1) if stats['total_responses'] > 0 else 0

# ============================================
# Export 2: Age Group Distribution
# ============================================
cursor.execute("""
    SELECT 
        age_group,
        COUNT(*) as count,
        ROUND(AVG(importance_rating), 1) as avg_importance
    FROM survey_responses
    GROUP BY age_group
    ORDER BY age_group
""")
age_distribution = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 3: Education Level Distribution
# ============================================
cursor.execute("""
    SELECT 
        education_level,
        COUNT(*) as count,
        ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) as percentage
    FROM survey_responses
    GROUP BY education_level
    ORDER BY count DESC
""")
education_distribution = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 4: Occupation Distribution
# ============================================
cursor.execute("""
    SELECT 
        occupation,
        COUNT(*) as count,
        ROUND(AVG(importance_rating), 1) as avg_importance,
        ROUND(AVG(usefulness_rating), 1) as avg_usefulness
    FROM survey_responses
    GROUP BY occupation
    ORDER BY count DESC
""")
occupation_distribution = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 5: All Survey Responses
# ============================================
cursor.execute("SELECT * FROM survey_responses ORDER BY response_id")
all_responses = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 6: References
# ============================================
cursor.execute("""
    SELECT 
        title,
        authors,
        publication_year,
        source_type,
        publisher,
        ieee_citation
    FROM _references
    ORDER BY publication_year DESC, authors
""")
references = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 7: Team Members
# ============================================
cursor.execute("""
    SELECT 
        full_name,
        registration_number,
        _role as role,
        email,
        github_username,
        contribution_areas
    FROM team_members
    ORDER BY full_name
""")
team_members = [dict(row) for row in cursor.fetchall()]

# ============================================
# Export 8: Concerns (for word cloud or list)
# ============================================
cursor.execute("""
    SELECT concerns
    FROM survey_responses
    WHERE concerns IS NOT NULL AND concerns != ''
""")
concerns = [row['concerns'] for row in cursor.fetchall()]

# ============================================
# Save all to JSON files
# ============================================
exports = {
    'survey-stats.json': stats,
    'age-distribution.json': age_distribution,
    'education-distribution.json': education_distribution,
    'occupation-distribution.json': occupation_distribution,
    'survey-responses.json': all_responses,
    'references.json': references,
    'team-members.json': team_members,
    'concerns.json': concerns
}

for filename, data in exports.items():
    filepath = os.path.join(output_dir, filename)
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    print(f"✅ {filename} created")

conn.close()
print(f"\n🎉 All data exported successfully to {output_dir}/")