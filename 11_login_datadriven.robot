*** Settings ***
Resource          common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie
Test Template     Inloggen Met Verschillende Gegevens

*** Test Cases ***
Correcte inlog                    tomsmith          SuperSecretPassword!    You logged into a secure area!
Foute gebruikersnaam              verkeerd          SuperSecretPassword!    Your username is invalid!
Fout wachtwoord                   tomsmith          verkeerd                Your password is invalid!
Lege velden                       ${EMPTY}          ${EMPTY}                Your username is invalid!

*** Keywords ***
Inloggen Met Verschillende Gegevens
    [Arguments]    ${username}    ${password}    ${expected_message}
    Go To    ${URL}/login
    # Hier gebruiken we nu ons eigen "super-keyword"
    Vul Inloggegevens In En Verstuur    ${username}    ${password}
    Get Text     id=flash    contains    ${expected_message}