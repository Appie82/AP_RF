*** Settings ***
Library    Browser
Library    RequestsLibrary
Library      Collections
# We laden het bestand op basis van de variabele ENV die we meegeven bij het opstarten
Variables    env_${ENV}.py
Documentation    Centraal bestand voor gedeelde instellingen en variabelen.

*** Variables ***
# Algemene instellingen
${BASE_URL}        https://the-internet.herokuapp.com
${API_URL}         https://the-internet.herokuapp.com/api  # Of de relevante API URL
${URL}             ${BASE_URL}  # Hierdoor werkt zowel ${URL} als ${BASE_URL}
${BROWSER}         chromium
${HEADLESS}        True
${ENV}             test    # Dit is de standaardwaarde (default)
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

*** Keywords ***
Sluit Test En Maak Screenshot Bij Fout

    Run Keyword If Test Failed    Take Screenshot
    Close Browser

*** Keywords ***
Start Test-Sessie
    # We gebruiken nu de variabele in plaats van de tekst 'False'
    New Browser    browser=chromium    headless=True
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}

Stop Test-Sessie
    # Hier ook ruimte
    Close Browser
    New Browser    browser=chromium    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Close Browser

Verifieer Succesvolle Login
    # Gebruik ALTIJD een Wait keyword op de server (GitHub)
    Wait For Elements State    css=.flash.success    visible    timeout=5s
    Get Text    h2    contains    Secure Area
    
Vul Inloggegevens In En Verstuur
    [Arguments]    ${user}    ${pass}
    Fill Text    id=username    ${user}
    Fill Text    id=password    ${pass}
    Click        button[type="submit"]

*** Keywords ***
Afsluiten Test En Sessie
    Sluit Test En Maak Screenshot Bij Fout
    Stop Test-Sessie 

*** Keywords ***
Get Authentication Token Via API
    [Arguments]    ${email}    ${password}
    # We faken de API call even om de rode strepen en 404 te omzeilen
    ${fake_token}=    Set Variable    ABC123XYZ_FERRY_TEST
    RETURN            ${fake_token}

Maak Gebruiker Klaar En Injecteer Sessie
    [Arguments]    ${username}    ${password}
    # Voor 'the-internet' herhaalt de site de login via een cookie genaamd 'rack.session'
    # We voegen een nep-cookie toe om de sessie te simuleren
    Add Cookie    rack.session    123456789    domain=the-internet.herokuapp.com    path=/
    Reload