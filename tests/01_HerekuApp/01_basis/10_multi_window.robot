*** Settings ***
Resource          ../../../common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 10: Wisselen Tussen Tabbladen
    [Documentation]    Valideert navigatie over meerdere vensters door Page IDs te 
    ...                identificeren en de focus van de browser gericht te verplaatsen.
    
    Click    text=Multiple Windows
    
    # STAP 1: Context vastleggen
    # We slaan het ID van de huidige hoofdpagina op om later terug te kunnen keren.
    ${hoofd_pagina}=    Get Page Ids    active
    
    # STAP 2: Actie triggeren
    # Deze klik opent een nieuwe 'target="_blank"' link in een nieuw tabblad.
    Click    text=Click Here
    
    # STAP 3: Wachten op het nieuwe venster
    # We gebruiken een retry-mechanisme om te wachten tot de browser de nieuwe pagina herkent.
    ${alle_ids}=    Wait Until Keyword Succeeds    5s    0.5s    Check Pagina Aantal
    
    # STAP 4: Logica om het juiste ID te filteren
    # We loopen door alle geopende IDs om de referentie naar het nieuwe tabblad te vinden.
    FOR    ${id}    IN    @{alle_ids}
        IF    '${id}' != '${hoofd_pagina}[0]'
            ${nieuw_id}=    Set Variable    ${id}
        END
    END
    
    # STAP 5: Focus verplaatsen naar Nieuw Venster
    Switch Page    ${nieuw_id}
    Browser.Get Text       h3    ==    New Window
    
    # STAP 6: Focus herstellen naar Hoofdvenster
    # Dit bewijst dat we de controle behouden over de volledige browser-sessie.
    Switch Page    ${hoofd_pagina}[0]
    Browser.Get Text       h3    ==    Opening a new window

*** Keywords ***
Check Pagina Aantal
    [Documentation]    Hulpmiddel om te verifiëren of de browser meerdere pagina-IDs heeft.
    ${ids}=       Get Page Ids
    ${lengte}=    Get Length    ${ids}
    Should Be True    ${lengte} > 1
    RETURN    ${ids}