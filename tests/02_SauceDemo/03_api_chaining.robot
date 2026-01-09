*** Settings ***
Resource          ../../common.resource
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario: Log In Met Data Van API
    [Documentation]    Bewijst dat API data in de browser terechtkomt.
    [Tags]             chaining
    
    # 1. Haal de data op
    ${api_naam}=     common.Haal Gebruikersnaam Op Via API
        
    # 2. Gebruik de data in de browser
    Start Test-Sessie    ${SAUCE_URL}
    Fill Text           id=user-name    ${api_naam}
    Fill Text           id=password     secret_sauce
    Click               id=login-button
    
    # 3. Check of de foutmelding de naam van de API bevat
    # SauceDemo geeft een melding dat de gebruiker niet bestaat.
    Get Text            css=[data-test="error"]    contains    Username and password do not match
    Log                 De test is geslaagd met API-naam: ${api_naam}
    