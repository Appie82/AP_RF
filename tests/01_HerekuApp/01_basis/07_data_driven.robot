Efficiëntie-test. Gebruikt een Test Template om drie negatieve scenario's   
(verkeerd wachtwoord, onbekende gebruiker, lege velden) 
in één run te testen en controleert op de foutmelding "is invalid".

*** Settings ***
Resource        ../../../common.resource
# Hier definiëren we welk keyword als 'sjabloon' dient
Test Template   Inloggen Met Ongeldige Gegevens Zou Moeten Falen

*** Test Cases *** 
Verkeerd Wachtwoord      tomsmith           DitIsFout
Onbekende Gebruiker      albert             Wachtwoord123
Lege Velden              ${EMPTY}           ${EMPTY}

*** Keywords ***
Inloggen Met Ongeldige Gegevens Zou Moeten Falen
    [Arguments]    ${username}    ${password}
    Open Browser    ${BASE_URL}/login    headless=${HEADLESS}
    Fill Text       id=username    ${username}
    Fill Text       id=password    ${password}
    Click           button[type="submit"]
    
    # We checken of de foutmelding verschijnt (invalid username/password)
    Wait For Elements State    id=flash    visible    timeout=3s
    Get Text        id=flash    contains    is invalid