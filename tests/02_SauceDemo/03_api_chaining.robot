*** Settings ***
Resource          ../../common.resource
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario: Log In Met Data Van API
    [Documentation]    Verifieert de keten-integratie door een gebruikersnaam uit een API-call 
    ...                direct te gebruiken als input voor het browser-inlogformulier.
    [Tags]             chaining    integration

    # STAP 1: Backend Data Retrieval
    # We roepen het keyword aan uit common.resource die de GET-request naar de API afhandelt.
    ${api_naam}=     common.Haal Gebruikersnaam Op Via API
        
    # STAP 2: UI Interactie
    # We initialiseren de browser en vullen de velden met de zojuist opgehaalde data.
    Start Test-Sessie    ${SAUCE_URL}
    Fill Text           id=user-name    ${api_naam}
    Fill Text           id=password     secret_sauce
    Click               id=login-button
    
    # STAP 3: Validatie & Foutafhandeling
    # Omdat de API-naam willekeurig is, verwachten we een foutmelding van SauceDemo.
    # We controleren of de pagina correct reageert op de externe data.
    Browser.Get Text    css=[data-test="error"]    contains    Username and password do not match
    
    # STAP 4: Rapportage
    # We loggen de specifieke waarde zodat we in de log.html precies zien welke naam is gebruikt.
    Log    De test is geslaagd met API-naam: ${api_naam}
    