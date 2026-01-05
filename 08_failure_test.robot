*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Deze test dwingt een fout af om de screenshot-functionaliteit te testen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${BASE_URL}/login
    
    # We wachten kort op een knop die niet bestaat
    # Dit zal een TimeoutError geven en automatisch een screenshot maken
    Click    button#niet-bestaande-knop    timeout=5s