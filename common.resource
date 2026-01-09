*** Settings ***
Library     Browser
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BROWSER}           chromium
${HEADLESS}          True
${SLOWMO}            0.0s    # Zet dit op 0.0s voor de cloud (snelheid!)
# --- Object 1: The Internet (Heroku) ---
${HEROKU_URL}       https://the-internet.herokuapp.com
${DYNAMIC_URL}      ${HEROKU_URL}/dynamic_loading/1
${TABEL_URL}        ${HEROKU_URL}/challenging_dom

# --- Object 2: SauceDemo ---
${SAUCE_URL}        https://www.saucedemo.com

# --- Default (voor achterwaartse compatibiliteit met je oude tests) ---
${BASE_URL}         ${HEROKU_URL}

# Test Data
${VALID_USER}       tomsmith
${VALID_PW}         SuperSecretPassword!



*** Keywords ***
Open De Browser Op De Inlogpagina
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
    New Page       ${BASE_URL}/login

Start Test-Sessie
    [Arguments]    ${START_URL}=${HEROKU_URL}
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    # We maken een context aan die groot genoeg is voor beide sites
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${START_URL}

Stop Test-Sessie
    Close Browser

Maak Gebruiker Klaar En Injecteer Sessie
    [Arguments]    ${email}    ${password}
    Go To          ${BASE_URL}
    Add Cookie     rack.session    123456789    domain=the-internet.herokuapp.com    path=/
    Reload
Log In Met Gebruiker
    [Arguments]    ${username}    ${password}
    Fill Text      id=username    ${username}
    Fill Text      id=password    ${password}
    Click          button[type="submit"]

Sluit Test En Maak Screenshot Bij Fout
    Run Keyword If Test Failed    Take Screenshot
    Close Browser

Afsluiten Test En Sessie
    Sluit Test En Maak Screenshot Bij Fout

Vul Inloggegevens In En Verstuur
    [Arguments]    ${user}    ${pass}
    # We hergebruiken het bestaande login keyword om dubbele code te voorkomen
    Log In Met Gebruiker    ${user}    ${pass}

Haal Gebruikersnaam Op Via API
    [Documentation]    Gebruikt JSONPlaceholder als alternatief voor ReqRes.
    Create Session    placeholder    https://jsonplaceholder.typicode.com    verify=True
    ${response}=      GET On Session    placeholder    /users/1    expected_status=200
    
    # JSONPlaceholder geeft 'name' terug (bijv. "Leanne Graham")
    ${volledige_naam}=    Set Variable      ${response.json()['name']}
    # We pakken alleen de voornaam (alles voor de eerste spatie)
    ${voornaam}=          Evaluate          "${volledige_naam}".split()[0]
    RETURN                ${voornaam}