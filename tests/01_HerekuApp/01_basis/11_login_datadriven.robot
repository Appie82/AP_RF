Dynamische Validatie. Breidt het template-concept uit: de tabel bevat nu ook de verwachte tekst. 
Hierdoor kan één test zowel een succesvolle login (groene melding) 
als verschillende foutmeldingen (rode melding) in één run controleren.

** Settings ***
Resource         ../../common.resource
Test Setup       Start Test-Sessie
Test Teardown    Afsluiten Test En Sessie
Test Template    Inloggen Met Verschillende Gegevens

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