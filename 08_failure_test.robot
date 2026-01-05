*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Deze test dwingt een fout af om de screenshot-functionaliteit te testen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${BASE_URL}/login
    
    # Zet de standaard timeout voor deze specifieke test op 5 seconden
    Set Browser Timeout    5s
    
    # Nu zal dit keyword na 5 seconden falen zonder dat we extra parameters nodig hebben
    Click    button#niet-bestaande-knop