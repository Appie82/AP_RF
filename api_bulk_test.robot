*** Settings ***
Library           DateTime
Library           DatabaseLibrary
Library           RequestsLibrary
Library           SeleniumLibrary
Suite Setup       Initialiseer Test
Suite Teardown    Sluit Alles Af

*** Variables ***
${API_URL}        https://jsonplaceholder.typicode.com
${DB_BESTAND}     keten_test.db
${LOGIN_URL}      https://practicetestautomation.com/practice-test-login/
${BROWSER}        chrome

*** Test Cases ***
Meerdere Users Volledige Keten Test
    [Documentation]    Haalt 10 gebruikers op, slaat ze op en test de login.
    
    Create Session    api_sessie    ${API_URL}    verify=True
    
    FOR    ${id}    IN RANGE    1    11
        # --- STAP 1: API ---
        ${resp}           GET On Session    api_sessie    /users/${id}
        ${naam}           Set Variable      ${resp.json()['username']}
        
        # --- STAP 2: DATA UNIEK MAKEN ---
        ${tijd}           Get Current Date    result_format=%H%M%S
        ${unieke_naam}    Set Variable        ${naam}_${tijd}
        
        # --- STAP 3: DATABASE ---
        Execute Sql String    INSERT INTO users (username, status) VALUES ('${unieke_naam}', 'bulk_test');
        
        # --- STAP 4: WEB UI ---
        Open Browser               ${LOGIN_URL}    ${BROWSER}
        Input Text                 id=username      ${unieke_naam}
        Input Password             id=password      Password123
        Click Button               id=submit
        
        Wait Until Element Is Visible    id=error    timeout=5s
        Element Should Be Visible        id=error
        
        Log    Keten voor user ${id} (${unieke_naam}) succesvol doorlopen.
        Close Browser
    END

    # Eindscheck in de Database: We verwachten er nu 10!
    ${count}    Row Count    SELECT id FROM users WHERE status = 'bulk_test'
    Should Be Equal As Integers    ${count}    10

*** Keywords ***
Initialiseer Test
    Connect To Database    sqlite3    ${DB_BESTAND}
    Execute Sql String     CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, status TEXT);
    Execute Sql String     DELETE FROM users WHERE status = 'bulk_test';

Sluit Alles Af
    Disconnect From Database