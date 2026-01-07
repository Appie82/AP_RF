*** Settings ***
Library     Browser
Library     RequestsLibrary
Library     Collections
Variables   env_${ENV}.py
Documentation    Centraal bestand voor gedeelde instellingen en variabelen.

*** Variables ***
${BASE_URL}         https://the-internet.herokuapp.com
${URL}              ${BASE_URL}
${BROWSER}          chromium
${HEADLESS}         True    # Staat nu standaard op True voor GitHub Actions
${ENV}              test
${SLOWMO}           0s      # Zet dit in CI op 0s om tijd te besparen

*** Keywords ***
Start Test-Sessie
    [Documentation]    Opent de browser met de juiste instellingen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}

Stop Test-Sessie
    [Documentation]    Sluit alles netjes af.
    Close Browser

Sluit Test En Maak Screenshot Bij Fout
    Run Keyword If Test Failed    Take Screenshot
    Stop Test-Sessie

Maak Gebruiker Klaar En Injecteer Sessie
    [Arguments]    ${username}    ${password}
    # Zorg dat we eerst op de domein-pagina zijn voordat we een cookie zetten
    Go To         ${BASE_URL}
    Add Cookie    rack.session    123456789    domain=the-internet.herokuapp.com    path=/
    Reload