*** Settings ***
Resource          common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Wisselen Tussen Tabbladen
    [Documentation]    Schakelen door de exacte technische ID's te vangen.
    Click    text=Multiple Windows
    
    # 1. Sla het ID van de huidige (hoofd) pagina op
    ${hoofd_pagina}=    Get Page Ids    active
    
    # 2. Klik op de link die een nieuw tabblad opent
    Click    text=Click Here
    
    # 3. Wacht tot er een tweede ID bij komt en pak de lijst
    ${alle_ids}=    Wait Until Keyword Succeeds    5s    0.5s    Check Pagina Aantal
    
    # 4. Zoek het ID dat NIET gelijk is aan onze hoofdpagina
    FOR    ${id}    IN    @{alle_ids}
        IF    '${id}' != '${hoofd_pagina}[0]'
            ${nieuw_id}=    Set Variable    ${id}
        END
    END
    
    # 5. Schakel naar het nieuwe ID en controleer tekst
    Switch Page    ${nieuw_id}
    Get Text       h3    ==    New Window
    
    # 6. Schakel terug naar het opgeslagen hoofd ID
    Switch Page    ${hoofd_pagina}[0]
    Get Text       h3    ==    Opening a new window

*** Keywords ***
Check Pagina Aantal
    ${ids}=    Get Page Ids
    ${lengte}=    Get Length    ${ids}
    Should Be True    ${lengte} > 1
    RETURN    ${ids}