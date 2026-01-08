Snelheidsoptimalisatie. In plaats van inloggen via de UI, injecteert deze test direct een rack.session cookie in de browser-context. 
Dit bewijst dat je weet hoe je de staat van een browser kunt manipuleren om tijdrovende stappen over te slaan.
*** Settings ***
Resource          ../../../common.resource
# De Setup opent de browser één keer op de juiste manier
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Scenario 13: Hybride Sessie Injectie
    [Documentation]    Test of we een sessie kunnen injecteren zonder opnieuw in te loggen.
    [Tags]    geavanceerd    api
    
    # We hoeven hier geen 'New Browser' meer te typen, dat doet de Setup al
    # We roepen direct het keyword aan uit de common.resource
    Maak Gebruiker Klaar En Injecteer Sessie    admin@test.nl    Password123
    
    # Verificatie: na de reload in het keyword zouden we ingelogd moeten lijken
    # (Let op: dit werkt alleen als de site de cookie accepteert)
    Get Url    contains    the-internet.herokuapp.com