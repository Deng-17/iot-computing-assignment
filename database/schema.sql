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
    education_level TEXT NOT NULL CHECK(education_level IN ('High School or below', 'College', 'Bachelors degree', 'Masters degree or higher', 'Prefer not to say')),
    occupation TEXT NOT NULL CHECK(occupation IN ('Student', 'Employed in tech/IT', 'Employed in non-tech', 'Self-employed', 'Unemployed', 'Retired', 'Other')),
    
    -- IoT Awareness
    heard_of_iot TEXT NOT NULL CHECK(heard_of_iot IN ('Yes', 'No', 'Somewhat')),
    familiarity_level INTEGER CHECK(familiarity_level BETWEEN 1 AND 4),
    
    -- Ratings (1-5 scale)
    importance_rating INTEGER CHECK(importance_rating BETWEEN 1 AND 5),
    usefulness_rating INTEGER CHECK(usefulness_rating BETWEEN 1 AND 5),
    relevance_rating INTEGER CHECK(relevance_rating BETWEEN 1 AND 5),
    future_impact_rating INTEGER CHECK(future_impact_rating BETWEEN 1 AND 5),
    
    -- Open-ended responses (NO CHECK CONSTRAINTS - free text allowed)
    valuable_applications TEXT,
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
-- Data Insertion
-- ============================================

-- Survey responses
INSERT INTO survey_responses (
    age_group, education_level, occupation, heard_of_iot, familiarity_level,
    importance_rating, usefulness_rating, relevance_rating, future_impact_rating,
    valuable_applications, standout_benefit, concerns
) VALUES 
('18-24','Bachelors degree','Student','Yes',2,4,3,4,3,'Industrial automation, Agriculture sensors','Research','What they think is right'),
('18-24','College','Student','No',NULL,1,1,1,1,'Smart home devices','Wearable health trackers','High implementation costs and interoperability challenges'),
('18-24','Bachelors degree','Student','Yes',1,5,5,3,5,'Smart home devices','Smart tools and gadgets','They still have not got what the full definition of IoT is'),
('18-24','College','Student','Yes',2,5,4,4,4,'Wearable health trackers','Eases monitoring',NULL),
('18-24','High School or below','Student','Yes',1,3,3,5,4,'Industrial automation','Eases work',NULL),
('18-24','High School or below','Student','Yes', 1,3,3,3,3,'Wearable health trackers','Dont really know',NULL),
('18-24','High School or below','Student','No',NULL,3,3,3,3,'Smart home devices','Accessibility',NULL),
('18-24','Prefer not to say','Student','No',NULL,3,3,3,3,'Wearable health trackers','Dont really know',NULL),
('18-24','College','Student','Yes',1,3,3,3,3,'Smart home devices, Wearable health trackers, Smart city traffic','Integrity',NULL),
('18-24','Bachelors degree','Student','Yes',2,1,2,4,5,'Smart home devices, Industrial automation','There is increased efficiency and automation of tasks','Encourage integration of IoT in curriculum to prepare students for the changing and connected world'),
('18-24','Prefer not to say','Student','Yes',3,5,5,5,5,'Smart home devices, Wearable health trackers, Industrial automation, Smart city traffic, Agriculture sensors','Very reliable',NULL),
('18-24','Bachelors degree','Student','No',NULL,4,4,4,4,'Smart home devices, Wearable health trackers','Its literally the Internet of Things',NULL),
('18-24','Bachelors degree','Student','Yes',3,5,5,4,5,'Smart home devices, Wearable health trackers, Industrial automation, Smart city traffic, Agriculture sensors','Perfect',NULL),
('18-24','Bachelors degree','Student','Yes',2,4,5,4,4,'Smart home devices, Industrial automation, Illustrative and modelling software','Global trend connectivity, limitless boundaries','Enforce and update learning outcomes to target internet of things'),
('25-34','Masters degree or higher','Student','No',NULL,3,4,5,4,'Smart city traffic, Agriculture sensors','Traffic lights because in a way it reduces on rate of roads accidents',NULL),
('25-34','Bachelors degree','Employed in non-tech','Yes',3,5,5,5,5,'Smart home devices, Wearable health trackers, Smart city traffic, Industrial automation, Agriculture sensors','Improving of a person’s wellbeing especially mentally',NULL),
('25-34','Bachelors degree','Unemployed','Yes',1,4,2,5,4,'Smart home devices',NULL,NULL),
('18-24','Bachelors degree','Student','Yes',3,5,3,4,4,'Agriculture sensors','Technology','Its good'),
('18-24','Bachelors degree','Student','No',NULL,5,5,5,5,'Wearable health trackers, Agriculture sensors','Saving funds',NULL),
('18-24','Bachelors degree','Student','Yes',4,5,5,4,4,'Wearable health trackers, Smart city traffic','The ability to connect and exchange data between devices allows for real-time monitoring, automation, and enhanced decision-making across various applications','Policymakers should establish flexible, outcome-based regulations prioritizing strong default security, clear data privacy standards (including explicit user consent), and clear accountability for manufacturers. Educators should focus on incorporating digital literacy, cybersecurity, and ethical data use into the curriculum, while institutions must provide adequate training and secure infrastructure to manage these technologies responsibly'),
('18-24','High School or below','Student','Yes',3,4,3,4,5,'Industrial automation','Uses of IoT sensors in industrial automation would accelerate value addition in agriculture','The benefits of IoT might be reaped via an interdisciplinary approach - by integration with both existing and emerging platforms for information processing'),
('Under 18','High School or below','Student','No',NULL,3,2,3,4,'Smart home devices',NULL,NULL),
('35-44','College','Student','Yes',3,3,5,4,4,'Agriculture sensors','The potential for aggregated data from underserved communities, using voice to bypass literacy and education barriers','Its use for trivial things (eg lights, music systems) and potentially for data monitoring breaches');

-- References
INSERT INTO _references (
    title, authors, publication_year, source_type, publisher, ieee_citation
) VALUES
('Internet of Things: A Survey on Enabling Technologies, Protocols, and Applications','A. Al-Fuqaha, M. Guizani, M. Mohammadi, M. Aledhari, and M. Ayyash',2015,'Journal','IEEE Communications Surveys & Tutorials','A. Al-Fuqaha, M. Guizani, M. Mohammadi, M. Aledhari, and M. Ayyash, "Internet of Things: A Survey on Enabling Technologies, Protocols, and Applications," IEEE Commun. Surveys Tuts., vol. 17, no. 4, pp. 2347-2376, Fourthquarter 2015.'),
('The Internet of Things for Health Care: A Comprehensive Survey','S. M. R. Islam, D. Kwak, M. H. Kabir, M. Hossain, and K. S. Kwak',2015,'Journal','IEEE Access','S. M. R. Islam, D. Kwak, M. H. Kabir, M. Hossain, and K. S. Kwak, "The Internet of Things for Health Care: A Comprehensive Survey," IEEE Access, vol. 3, pp. 678-708, 2015.'),
('IoT Security: Review, Blockchain Solutions, and Open Challenges','M. A. Khan and K. Salah',2018,'Journal','Future Generation Computer Systems','M. A. Khan and K. Salah, "IoT Security: Review, Blockchain Solutions, and Open Challenges," Future Gener. Comput. Syst., vol. 82, pp. 395-411, May 2018.');

-- Team members
INSERT INTO team_members (full_name, registration_number, _role, email, github_username, contribution_areas) VALUES
('Deng Yak Deng Ater', '25/X/BIO/01367/PD', 'Group Lead, Database & Web Dev', 'dengater17@gmail.com', 'Deng-17', 'Database design, website development, GitHub management'),
('Namuganza Maria Gorret', '25/U/BIO/027/GV', 'Report Coordinator', 'namuganzamariagorret@gmail.com', 'namuganzamariagorret-tech', 'Report writing, literature review, formatting'),
('Kibi Darius', '25/U/BIO/01383/PD', 'Researcher & Data Analyst', 'dariokibi806@gmail.com', 'dariokibi806-dev', 'Research, survey design, data analysis, Excel charts'),
('Odora Stephen', '25/U/BIO/01411/PD', 'Media & Presentation', 'stephenodora22@gmail.com', 'Steve16-code', 'Video editing, poster design, presentation slides, graphics'),
('Otim Amos', '25/U/01416/PD', 'Quality Assurance', 'amosotimfaith2004@gmail.com', 'amosotim', 'Testing, proofreading, final review'),
('Kusena Jimmy', '25/U/BIO/01389/PD', 'Documentation & Support', 'jimmieplaise@gmail.com', 'jimmieplaise-ctrl', 'Documentation, technical support, user assistance'),
('Jakira Juma Fahad', '25/U/BIO/01374/PD', 'Data Collection & Research', 'jakirajumafahad@gmail.com', 'jakirajumafahad', 'Data collection, research assistance, fieldwork');