Veel applicaties gebruiken browser-popups voor belangrijke acties (zoals "Weet u zeker dat u wilt verwijderen?"). 
Dit moet je framework blindelings kunnen afhandelen.
*** Settings ***
Resource          ../../common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 09: Bevestig Een JavaScript Alert
    [Documentation]    Test de interactie met browser-native popups (Alerts en Confirms).
    Go To    ${BASE_URL}/javascript_alerts
    
    # We vertellen de browser wat hij moet doen ZODRA er een alert verschijnt
    Handle Future Dialogs    action=accept
    
    # Trigger de alert
    Click    button >> text=Click for JS Confirm
    
    # Verifieer of de pagina de bevestiging herkent
    Get Text    id=result    ==    You clicked: Ok