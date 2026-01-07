*** Settings ***
Resource          ../../../common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 05: Selecteer Optie Uit Dropdown
    [Documentation]    Verifieert of we een waarde kunnen kiezen uit een standaard HTML-select menu.
    Go To    ${BASE_URL}/dropdown
    
    # Selecteer op label (de tekst die de gebruiker ziet)
    Select Options By    id=dropdown    text    Option 2
    
    # Verifieer of de juiste optie nu geselecteerd is
    Get Selected Options    id=dropdown    label    ==    Option 2