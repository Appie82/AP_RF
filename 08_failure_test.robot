*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Deze test dwingt een fout af om de screenshot-functionaliteit te testen.
    # We zorgen dat de browser niet in interactieve debug-modus gaat
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    
    # Gebruik een schone context zonder pauzeer-instellingen
    New Context    
    New Page       ${BASE_URL}/login
    
    # Zet de timeout kort voor de snelle faal
    Set Browser Timeout    5s
    
    # Forceer de klik. Als dit faalt, zal de Browser library 
    # automatisch een screenshot maken en de test stoppen.
    Click    button#niet-bestaande-knop