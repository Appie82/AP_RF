*** Settings ***
Library      Browser
Library      RequestsLibrary
# We laden het bestand op basis van de variabele ENV die we meegeven bij het opstarten
Variables    env_${ENV}.py
Documentation    Centraal bestand voor gedeelde instellingen en variabelen.

*** Variables ***
# Algemene instellingen
${BROWSER}         chromium
${HEADLESS}        True
${ENV}             test    # Dit is de standaardwaarde (default)
${BASE_URL}        https://the-internet.herokuapp.com
${SLOWMO}          0.5s

# Specifieke pagina URL's
${LOGIN_URL}       ${BASE_URL}/login
${TABEL_URL}       ${BASE_URL}/challenging_dom
${DYNAMIC_URL}     ${BASE_URL}/dynamic_loading/1

# Test data
#${VALID_USER}      tomsmith    Niet meer nodig, vanwege de test_data.py
#${VALID_PW}        SuperSecretPassword!  Niet meer nodig, vanwege de test_data.py

*** Keywords ***
Open De Browser Op De Inlogpagina
    # We voegen slowMo direct toe aan de browser instellingen
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}
    New Page       ${LOGIN_URL}

Log In Met Gebruiker
    [Arguments]    ${username}    ${password}
    Fill Text      id=username    ${username}
    Fill Text      id=password    ${password}
    Click          button[type="submit"]

Sluit Test En Maak Screenshot Bij Fout
    # 'Run Keyword If Test Failed' is een ingebouwd commando
    Run Keyword If Test Failed    Take Screenshot    fullPage=True