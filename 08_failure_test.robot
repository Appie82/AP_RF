*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Deze test dwingt een fout af om de screenshot-functionaliteit te testen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${BASE_URL}/login
    
    # We voegen 'timeout=' toe zodat de library snapt dat dit geen muisknop is
    Click    button#niet-bestaande-knop    timeout=5s