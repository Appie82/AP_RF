*** Settings ***
Library    Browser
Library    RequestsLibrary
Library    Collections


*** Variables ***
${BROWSER}           chromium
${HEADLESS}          False
${SLOWMO}            00:00:01  #Langzamer voor de demo
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

# Variabelen voor Sauce Labs (Cloud)
${SAUCE_USERNAME}    %{SAUCE_USERNAME=placeholder_user}
${SAUCE_ACCESS_KEY}  %{SAUCE_ACCESS_KEY=placeholder_key}
${REMOTE_URL}        https://ondemand.eu-central-1.saucelabs.com:443/wd/hub


*** Keywords ***
*** Keywords ***
Initialiseer Database Connectie
    # We vertellen de robot: Gebruik SQLite, en dit is het bestand
    Connect To Database    sqlite3    keten_test.db

Open De Browser Op De Inlogpagina
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
    New Page       ${BASE_URL}/login

Start Test-Sessie
    [Arguments]    ${START_URL}=${HEROKU_URL}
    # Deze regel lost je huidige foutmeldingen op:
    Set Library Search Order    Browser    Mobile
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
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

