*** Settings ***
Resource          ../../../common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 09: Bevestig Een JavaScript Alert
    [Documentation]    Valideert de automatische afhandeling van native JS-confirms.
    ...                Demonstreert het 'event-listening' principe van de Browser Library.
    
    # Navigeer naar de pagina met interactieve elementen
    Go To    ${BASE_URL}/javascript_alerts
    
    # STAP 1: Event Listener instellen
    # We vertellen de browser: "Zodra er een dialoog verschijnt, klik op 'OK' (accept)".
    # Dit moet gebeuren VOORDAT we op de knop klikken, anders loopt de test vast.
    Handle Future Dialogs    action=accept
    
    # STAP 2: Actie triggeren
    # We klikken op de knop die de JS Confirm-box oproept.
    Click    button >> text=Click for JS Confirm
    
    # STAP 3: Validatie
    # We controleren of de webpagina de bevestiging van de browser heeft ontvangen.
    Browser.Get Text    id=result    ==    You clicked: Ok
    
    Log    Native browser dialoog succesvol afgehandeld via Handle Future Dialogs.