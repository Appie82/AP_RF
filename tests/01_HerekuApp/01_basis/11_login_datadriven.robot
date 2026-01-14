*** Settings ***
Resource         ../../../common.resource
Test Setup       Start Test-Sessie
Test Teardown    Afsluiten Test En Sessie
# Het template definieert de actie die voor ELKE rij in de tabel wordt uitgevoerd
Test Template    Inloggen Met Verschillende Gegevens

*** Test Cases ***
# | Scenario Naam | Gebruikersnaam | Wachtwoord | Verwachte Melding (Assert) |
Correcte inlog          tomsmith         SuperSecretPassword!     You logged into a secure area!
Foute gebruikersnaam    verkeerd         SuperSecretPassword!     Your username is invalid!
Fout wachtwoord         tomsmith         verkeerd                 Your password is invalid!
Lege velden             ${EMPTY}         ${EMPTY}                 Your username is invalid!

*** Keywords ***
Inloggen Met Verschillende Gegevens
    [Documentation]    Dit keyword is de 'engine' die dynamisch omgaat met zowel 
    ...                positieve als negatieve scenario's.
    [Arguments]        ${username}    ${password}    ${expected_message}
    
    # 1. Navigatie naar de inlogomgeving
    Go To    ${BASE_URL}/login
    
    # 2. Abstractie: We gebruiken een herbruikbaar keyword voor de UI-acties
    Vul Inloggegevens In En Verstuur    ${username}    ${password}
    
    # 3. Dynamische Assertie: De verificatie past zich aan op basis van de testdata.
    # Of het nu een groene succes-banner is of een rode foutmelding, de test valideert de tekst.
    Browser.Get Text     id=flash    contains    ${expected_message}
    
    Log    Validatie succesvol uitgevoerd voor scenario: ${username}