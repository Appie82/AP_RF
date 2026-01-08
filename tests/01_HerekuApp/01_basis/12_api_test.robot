Protocol Validatie. Gebruikt het Http keyword binnen de browser om direct de statuscode (200 OK) 
en de ruwe body-content van de loginpagina te verifiëren.

*** Settings ***
Resource          ../../../common.resource
Library           Browser
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Check Of De Website Online Is Via API
    [Documentation]    We vuren een HTTP-verzoek af binnen een actieve browser-context.
    
    # Het Http keyword gebruikt de huidige browser-sessie
    ${response}=    Http    ${BASE_URL}/login
    
    # We controleren de statuscode (moet 200 zijn)
    Should Be Equal    ${response}[status]    ${200}
    
    # We checken of de body de juiste tekst bevat
    Should Contain     ${response}[body]      login