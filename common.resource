*** Settings ***
Library     Browser
Library     RequestsLibrary
Library     Collections

*** Variables ***
# URL's
${BASE_URL}         https://the-internet.herokuapp.com
${URL}              ${BASE_URL}
${DYNAMIC_URL}      ${BASE_URL}/dynamic_loading/1
${TABEL_URL}        ${BASE_URL}/challenging_dom    

# Test Data
${VALID_USER}       tomsmith
${VALID_PW}         SuperSecretPassword!

# Instellingen
${BROWSER}          chromium
${HEADLESS}         False
${SLOWMO}           0.5s

*** Keywords ***
Open De Browser Op De Inlogpagina
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
    New Page       ${BASE_URL}/login

Start Test-Sessie
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}

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