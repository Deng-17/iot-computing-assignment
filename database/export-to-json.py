#! python3
# export-to-json.py

import os
import json
import sqlite3

# Create data directory if it doesn't exist
os.makedirs('../website/data', exist_ok=True)

# Connect to database
conn = sqlite3.connect('iot_comp_assignment.db')
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

print("📊 Exporting database to JSON files...")

# Export survey statistics
cursor.execute("""
    SELECT 
        COUNT(*) as total_responses,
        SUM(CASE WHEN heard_of_iot = 'Yes' THEN 1 ELSE 0 END) as heard_count,
        ROUND(AVG(familiarity_level), 2) as avg_familiarity,
        ROUND(AVG(importance_rating), 2) as avg_importance,
        ROUND(AVG(usefulness_rating), 2) as avg_usefulness,
        ROUND(AVG(relevance_rating), 2) as avg_relevance,
        ROUND(AVG(future_impact_rating), 2) as avg_future_impact
    FROM survey_responses
""")
stats = dict(cursor.fetchone())

# Export all survey responses
cursor.execute("SELECT * FROM survey_responses")
responses = [dict(row) for row in cursor.fetchall()]

# Export references (note the underscore)
cursor.execute("SELECT * FROM _references")
references = [dict(row) for row in cursor.fetchall()]

# Export team members (note the underscore in _role)
cursor.execute("SELECT * FROM team_members")
team = [dict(row) for row in cursor.fetchall()]

# Save to JSON files
with open('../website/data/survey-stats.json', 'w') as f:
    json.dump(stats, f, indent=2)
    print("✅ survey-stats.json created")

with open('../website/data/survey-responses.json', 'w') as f:
    json.dump(responses, f, indent=2)
    print("✅ survey-responses.json created")

with open('../website/data/references.json', 'w') as f:
    json.dump(references, f, indent=2)
    print("✅ references.json created")

with open('../website/data/team-members.json', 'w') as f:
    json.dump(team, f, indent=2)
    print("✅ team-members.json created")

conn.close()
print("\n🎉 All data exported successfully!")
print("Files location: website/data/")
