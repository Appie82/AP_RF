*** Settings ***
Resource          ../../../common.resource
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 05: Selecteer Optie Uit Dropdown
    [Documentation]    Valideert de interactie met HTML <select> elementen. 
    ...                De test controleert of een optie succesvol gekozen en bevestigd kan worden.
    
    # Navigeer naar de specifieke testpagina voor dropdowns
    Go To    ${BASE_URL}/dropdown
    
    # STAP 1: Selectie maken
    # Er zijn drie manieren om te selecteren: 'text' (zichtbaar), 'value' (code), of 'index' (positie).
    # We kiezen hier voor 'text' omdat dit het meest lijkt op echt gebruikersgedrag.
    Select Options By    id=dropdown    text    Option 2
    
    # STAP 2: Verificatie (Assertion)
    # We vragen de momenteel geselecteerde optie op en vergelijken deze met onze verwachting.
    # Dit is cruciaal om te bewijzen dat de UI daadwerkelijk is bijgewerkt.
    Get Selected Options    id=dropdown    label    ==    Option 2
    
    Log    Dropdown succesvol ingesteld op 'Option 2'.