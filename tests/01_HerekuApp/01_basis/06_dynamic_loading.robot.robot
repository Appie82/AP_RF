*** Settings ***
Resource          ../../../common.resource
# We gebruiken hier geen Test Setup omdat de browser specifiek in de test wordt geopend met settings
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 06: Wachten Op Dynamisch Element
    [Documentation]    Valideert de afhandeling van asynchrone content (AJAX). 
    ...                Deze test voorkomt 'flakiness' door intelligent te wachten op de UI-staat.
    
    # Navigeer naar de testpagina voor dynamisch laden
    Open Browser    ${BASE_URL}/dynamic_loading/2    headless=${HEADLESS}
    
    # STAP 1: Actie triggeren
    # We klikken op start; dit start een laadproces achter de schermen.
    Click    button >> text=Start
    
    # STAP 2: Intelligent Wachten (Synchronisatie)
    # In plaats van 'Sleep 5s', gebruiken we een dynamische wachtstap. 
    # De test gaat direct verder zodra de tekst zichtbaar is, wat tijd bespaart.
    Wait For Elements State    text=Hello World!    visible    timeout=10s
    
    # STAP 3: Validatie
    # We halen de tekst op van het element dat zojuist verschenen is.
    ${bericht}=    Browser.Get Text    id=finish
    Should Be Equal    ${bericht}    Hello World!
    
    Log    Dynamische content succesvol geladen na synchronisatie-wachtstap.