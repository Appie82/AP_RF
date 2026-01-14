*** Settings ***
Library           DateTime
Library           DatabaseLibrary
Library           RequestsLibrary
Suite Setup       Initialiseer Test
Suite Teardown    Disconnect From Database

*** Variables ***
${API_URL}        https://jsonplaceholder.typicode.com
${DB_BESTAND}     keten_test.db

*** Test Cases ***
Keten Van API Naar Unieke Database Invoer
    [Documentation]    Haalt een naam op uit de API en slaat deze uniek op in de DB.
    
    # 1. API STAP: Haal een gebruiker op
    Create Session    api_sessie    ${API_URL}    verify=True
    ${resp}           GET On Session    api_sessie    /users/2
        ${json}           Set Variable      ${resp.json()}
    ${api_naam}       Set Variable      ${json['username']}
    Log    Naam uit API is: ${api_naam}

    # 2. UNIEK MAKEN: Voeg tijdstempel toe
    ${tijd}           Get Current Date    result_format=%H%M%S
    ${unieke_naam}    Set Variable        ${api_naam}_${tijd}
    Log    De naam voor de database wordt: ${unieke_naam}

    # 3. DATABASE STAP: Opslaan
    Execute Sql String    INSERT INTO users (username, status) VALUES ('${unieke_naam}', 'api_import');
    
    # 4. VERIFICATIE: Controleer of de unieke naam erin staat
    Check Row Count       SELECT id FROM users WHERE username = '${unieke_naam}'    ==    1
    Log    Succes! Gebruiker ${unieke_naam} staat in de database.

*** Keywords ***
Initialiseer Test
    Connect To Database    sqlite3    ${DB_BESTAND}
    # Zorg dat de tabel klaarstaat
    Execute Sql String     CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, status TEXT);