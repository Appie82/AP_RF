*** Settings ***
Library    Browser
Documentation    Dit is de test suite voor het inlogproces van de Herokuapp site.

*** Variables ***
${HEADLESS}    True
${URL}         https://the-internet.herokuapp.com/login

*** Test Cases ***
Succesvol Inloggen Op Oefensite
    [Documentation]    Controleert of een gebruiker met de juiste gegevens toegang krijgt.
    [Tags]             Snooze    Regressie    Login
    
    New Browser    browser=chromium    headless=${HEADLESS}
    New Page       ${URL}
    
    Fill Text      id=username    tomsmith
    Fill Text      id=password    SuperSecretPassword!
    Click          button[type="submit"]
    
    # We herstellen de tekst hier naar de juiste waarde
    Get Text       h2    contains    Secure Area
    
    Take Screenshot

Foutmelding Bij Verkeerd Wachtwoord
    [Documentation]    Controleert of de juiste foutmelding verschijnt bij ongeldige gegevens.
    [Tags]             Login    Negative
    
    New Page       ${URL}
    Fill Text      id=username    verkeerde_gebruiker
    Fill Text      id=password    fout_wachtwoord
    Click          button[type="submit"]
    
    Get Text       id=flash    contains    Your username is invalid!
    
    Take Screenshot