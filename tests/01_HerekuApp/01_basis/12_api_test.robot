*** Settings ***
Resource          ../../../common.resource
Library           Browser
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 12: Check Of De Website Online Is Via API
    [Documentation]    Voert een snelle protocol-validatie uit binnen de actieve 
    ...                browser-context om de serverstatus en body-content te verifiëren.
    
    # STAP 1: HTTP-aanroep binnen de Browser
    # Het 'Http' keyword deelt de cookies en headers van de huidige browser-sessie.
    # Dit is sneller dan een volledige 'Go To' omdat er geen rendering plaatsvindt.
    ${response}=    Http    ${BASE_URL}/login
    
    # STAP 2: Statuscode Validatie
    # We verifiëren of de server antwoordt met de standaard '200 OK' status.
    # Let op: ${200} wordt als integer vergeleken voor maximale nauwkeurigheid.
    Should Be Equal    ${response}[status]    ${200}
    
    # STAP 3: Raw Body Inspectie
    # We scannen de ruwe HTML-broncode (body) op de aanwezigheid van kritieke termen.
    # Dit bevestigt dat niet alleen de server online is, maar ook de juiste pagina serveert.
    Should Contain     ${response}[body]      login
    
    Log    Protocol-check succesvol: Server status 200 en 'login' keyword gevonden in body.