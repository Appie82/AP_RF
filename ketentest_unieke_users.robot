*** Settings ***
Library           DateTime
Library           DatabaseLibrary
# De Suite Setup zorgt dat de database OPENT voor de test begint
Suite Setup       Verbinden Met Database
# De Suite Teardown sluit de verbinding netjes af als de test klaar is
Suite Teardown    Disconnect From Database

*** Variables ***
${DB_BESTAND}     keten_test.db

*** Test Cases ***
Test Met Unieke Gebruiker
    [Documentation]    Maakt een unieke naam aan voor deze specifieke run.
    
    # 1. Genereer een timestamp (bijv. 202601140959)
    ${tijd}           Get Current Date    result_format=%Y%m%d%H%M%S
    ${unieke_naam}    Set Variable        Tester_${tijd}
    
    Log    Deze test gebruikt de naam: ${unieke_naam}
    
    # 2. Gebruik deze naam in je Database
    # We voegen ook 'active' toe aan de status-kolom die ik in je screenshot zie
    Execute Sql String    INSERT INTO users (username, status) VALUES ('${unieke_naam}', 'active');
    
    # 3. Verificatie
    Check Row Count       SELECT id FROM users WHERE username = '${unieke_naam}'    ==    1

*** Keywords ***
Verbinden Met Database
    # Dit opent de verbinding met je databasebestand
    Connect To Database    sqlite3    ${DB_BESTAND}
    # Dit zorgt ervoor dat de tabel 'users' bestaat met de kolommen uit je screenshot
    Execute Sql String     CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, status TEXT);