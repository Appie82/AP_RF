*** Settings ***
Resource          ../../../common.resource
Test Teardown     Sluit Test En Maak Screenshot Bij Fout
Test Template     Inloggen Met Verschillende Gegevens

*** Test Cases ***
Correcte Gegevens                  tomsmith            SuperSecretPassword!      Secure Area
Verkeerd Wachtwoord                tomsmith            FoutWachtwoord            Your password is invalid!
Onbekende Gebruiker                Alber123            SuperSecretPassword!      Your username is invalid!
Lege Velden                        ${EMPTY}            ${EMPTY}                  Your username is invalid!

*** Keywords ***
Inloggen Met Verschillende Gegevens
    [Arguments]    ${user}    ${pass}    ${check_tekst}
    Open De Browser Op De Inlogpagina
    Log In Met Gebruiker    ${user}    ${pass}
    Get Text    body    contains    ${check_tekst}

    #Controleert de standaard inlogfunctionaliteit. 
    # De test vult handmatig gebruikersnaam en wachtwoord in 
    # en verifieert of het dashboard geladen wordt.