# Database Documentation

## Overview
SQLite database storing IoTresearch data with 23 survey responses.

## Tables
- **survey_responses** (23 records) - Public awareness survey data
- **_references** (10 records) - Research citations
- **team_members** (7 records) - Assignment team information and contribution tracking

## Setup Instructions
```bash
sqlite3 iot_comp_assignment.db < schema.sql
python export-to-json.py
```

## Design Decisions
- Used SQLite for portability
- Prefixed reserved keywords with underscore (_references, _role)
- CHECK constraints ensure data integrity
- JSON export for static website integration

## Statistics
- Total survey responses: 23
- Age groups covered: 7
- Education levels: 5
- Awareness rate: ~69%
