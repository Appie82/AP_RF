*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Deze test dwingt een fout af om de screenshot-functionaliteit te testen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    
    # We maken een nieuwe context aan en zorgen dat 'tracing' of 'pauze' niet aanstaat
    New Context    
    New Page       ${BASE_URL}/login
    
    # Zet de timeout kort
    Set Browser Timeout    5s
    
    # De test zal hier falen en direct afsluiten zonder te wachten op een Enter
    Click    button#niet-bestaande-knop