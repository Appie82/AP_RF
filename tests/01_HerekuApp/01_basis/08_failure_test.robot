*** Settings ***
Resource     ../../../common.resource

*** Test Cases ***
Test Negatieve Scenario Bevestiging
    [Documentation]    Valideert dat de UI correct reageert op afwezige elementen 
    ...                en de juiste foutmeldingen toont bij ongeldige credentials.

    # 1. Browser Setup
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login

    # STAP 2: De Detached State Check
    # We bewijzen dat een specifiek element (zoals een foutieve knop) NIET in de DOM staat.
    # 'detached' is veiliger dan 'hidden', omdat het bevestigt dat het element ook niet 
    # onzichtbaar op de achtergrond aanwezig is.
    Wait For Elements State    button#niet-bestaande-knop    state=detached    timeout=2s

    # STAP 3: Negatieve Inlog Validatie
    # We forceren een foutmelding door ongeldige data in te vullen.
    Fill Text    id=username    verkeerde_gebruiker
    Click        button[type="submit"]
    
    # STAP 4: Bevestiging van de foutmelding
    # De test slaagt (PASS) als de verwachte waarschuwing verschijnt.
    Browser.Get Text     id=flash    contains    Your username is invalid!
    
    Log    Negatieve validatie succesvol: Element is detached en foutmelding is zichtbaar.