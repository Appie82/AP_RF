*** Settings ***
Resource          common.resource
# Deze twee regels zorgen dat de browser automatisch start en stopt per test
Test Setup        Start Test-Sessie
Test Teardown     Stop Test-Sessie

*** Test Cases ***
Succesvol Inloggen
    [Documentation]    Controleert of een gebruiker kan inloggen met de juiste gegevens.
    # We hoeven niet meer naar de URL te navigeren, dat doet de Setup al
    Click       text=Form Authentication
    Fill Text   id=username    tomsmith
    Fill Text   id=password    SuperSecretPassword!
    Click       button[type="submit"]
    
    # Verificatie
    Get Text    h2    ==    Secure Area
    Get Text    id=flash    contains    You logged into a secure area!

Inloggen Met Verkeerde Gegevens
    [Documentation]    Controleert of er een foutmelding komt bij foute gegevens.
    Click       text=Form Authentication
    Fill Text   id=username    verkeerde_gebruiker
    Fill Text   id=password    fout_wachtwoord
    Click       button[type="submit"]
    
    # Verificatie van de foutmelding
    Get Text    id=flash    contains    Your username is invalid!