*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           SeleniumLibrary
Suite Setup       Keten Setup
Suite Teardown    Keten Teardown

*** Variables ***
${API_URL}        https://jsonplaceholder.typicode.com
${DB_NAME}        keten_test.db
${BROWSER}        chrome
${LOGIN_URL}      https://practicetestautomation.com/practice-test-login/

*** Test Cases ***
De Ultieme Keten Test
    [Documentation]    1. API (User ophalen) -> 2. DB (User opslaan) -> 3. UI (Inloggen)
    
    # --- STAP 1: API ---
    # We halen een test-gebruiker op van het internet
    Create Session    api_session    ${API_URL}    verify=True
    ${response}       GET On Session    api_session    /users/1
    ${user_json}      Set Variable      ${response.json()}
    ${username}       Set Variable      ${user_json['username']}
    Log    De naam uit de API is: ${username} (Appie Dubbeldam)

    # --- STAP 2: DATABASE ---
    # We slaan deze specifieke naam op in onze lokale database
    Execute Sql String    INSERT INTO users (username, status) VALUES ('${username}', 'active');
    
    # Controleer of hij er echt in staat
    Check Row Count       SELECT id FROM users WHERE username = '${username}'    ==    1
    Log    Gebruiker '${username}' succesvol geverifieerd in de database.

    # --- STAP 3: WEB UI ---
    Open Browser               ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Input Text                 id=username      ${username}
    Input Password             id=password      Password123
    Click Button               id=submit
    
    # VOEG DEZE REGEL TOE: Wacht tot de foutmelding verschijnt (max 5 seconden)
    Wait Until Element Is Visible    id=error    timeout=5s
    
    Element Should Be Visible  id=error
    Log    Web interface reageert correct op de data uit de API en DB.

*** Keywords ***
Keten Setup
    # Database voorbereiden
    Connect To Database    sqlite3    ${DB_NAME}
    Execute Sql String     DROP TABLE IF EXISTS users;
    Execute Sql String     CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT, status TEXT);

Keten Teardown
    Close All Browsers
    Disconnect From Database