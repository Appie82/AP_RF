#Afwezigheidscheck. Gebruikt de staat detached om te bewijzen dat een specifiek element 
#(zoals een foutieve knop) niet bestaat in de DOM. 
# Daarnaast wordt een foute inlog geprobeerd om de aanwezigheid 
# van een foutmelding te verifiëren.

*** Settings ***
Resource    ../../../../common.resource

*** Test Cases ***
Test Negatieve Scenario Bevestiging
    [Documentation]    Controleert of een niet-bestaand element inderdaad afwezig is.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login

    # In plaats van 'Click' (wat faalt), gebruiken we 'Wait For Elements State'
    # De status 'detached' betekent: het element is niet in de code aanwezig.
    Wait For Elements State    button#niet-bestaande-knop    state=detached    timeout=2s

    # Of we checken of een foutmelding verschijnt na een foutieve actie
    Fill Text    id=username    verkeerde_gebruiker
    Click        button[type="submit"]
    
    # Nu checken we of de foutmelding verschijnt (dit wordt een PASS)
    Get Text     id=flash    contains    Your username is invalid!