*** Settings ***
Library           DateTime
Library           DatabaseLibrary
Library           RequestsLibrary
Library           Browser    # Playwright engine voor betere stabiliteit
Suite Setup       Initialiseer Test
Suite Teardown    Sluit Alles Af

*** Variables ***
${API_URL}         https://jsonplaceholder.typicode.com
${DB_BESTAND}      keten_test.db
${LOGIN_URL}       https://practicetestautomation.com/practice-test-login/
${BROWSER}         chromium
${HEADLESS}        False    # Zichtbaar voor je collega's

*** Test Cases ***
Meerdere Users Volledige Keten Test
    [Documentation]    Haalt 10 gebruikers op, slaat ze op en test de login.
    ...                Geoptimaliseerd voor visuele presentatie.
    
    Create Session    api_sessie    ${API_URL}    verify=True
    
    # Start de browser één keer op met SlowMo voor de presentatie
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=00:00:00.8
    New Context    viewport={'width': 1280, 'height': 720}

    FOR    ${id}    IN RANGE    1    11
        # --- STAP 1: API ---
        ${resp}           GET On Session    api_sessie    /users/${id}
        ${naam}           Set Variable      ${resp.json()['username']}
        
        # --- STAP 2: DATA UNIEK MAKEN ---
        ${tijd}           Get Current Date    result_format=%H%M%S
        ${unieke_naam}    Set Variable        ${naam}_${tijd}
        
        # --- STAP 3: DATABASE ---
        Execute Sql String    INSERT INTO users (username, status) VALUES ('${unieke_naam}', 'bulk_test');
        
        # --- STAP 4: WEB UI (Met de FIX voor de foutmelding) ---
        New Page          ${LOGIN_URL}
        
        # DE OPLOSSING: Expliciet wachten tot de pagina geladen is en het veld zichtbaar is
        Wait For Elements State    id=username    visible    timeout=10s
        
        Fill Text         id=username    ${unieke_naam}
        Fill Text         id=password    Password123
        Click             id=submit
        
        # Verifieer de foutmelding (omdat de user niet echt bestaat in hun systeem)
        Wait For Elements State    id=error    visible    timeout=5s
        Get Text          id=error    contains    Your username is invalid!
        
        Log    Keten voor user ${id} (${unieke_naam}) succesvol doorlopen.
    END

    # Eindscheck in de Database
    ${count}    Row Count    SELECT id FROM users WHERE status = 'bulk_test'
    Should Be Equal As Integers    ${count}    10

*** Keywords ***
Initialiseer Test
    Connect To Database    sqlite3    ${DB_BESTAND}
    # DE FIX: Maak de tabel leeg voor de start, zodat we altijd met 0 beginnen
    Execute Sql String     DELETE FROM users WHERE status = 'bulk_test';
    Log    Database opgeschoond voor een betrouwbare baseline.

Sluit Alles Af
    Disconnect From Database
    Close Browser    ALL