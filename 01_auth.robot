*** Settings ***
Resource         ../common.resource
Test Setup       Start Test-Sessie
Test Teardown    Sluit Test En Maak Screenshot Bij Fout
# Hieronder wijzen we het keyword aan dat als 'sjabloon' dient
Test Template    Inloggen Met Verschillende Gegevens

*** Test Cases *** 
Correcte Gegevens                 ${VALID_USER}        ${VALID_PW}       Secure Area
Verkeerd Wachtwoord               ${VALID_USER}        FoutWachtwoord    Your password is invalid!
Onbekende Gebruiker               Alber123             ${VALID_PW}       Your username is invalid!
Lege Velden                       ${EMPTY}             ${EMPTY}          Your username is invalid!

*** Keywords ***
Inloggen Met Verschillende Gegevens
    [Arguments]    ${user}    ${pass}    ${check_tekst}
    Open De Browser Op De Inlogpagina
    Log In Met Gebruiker    ${user}    ${pass}
    # We checken of de verwachte tekst ergens op de pagina verschijnt
    Get Text    body    contains    ${check_tekst}