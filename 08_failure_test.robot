*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    Open Browser    ${BASE_URL}/login    headless=${HEADLESS}
    # Deze selector bestaat niet, dus de test faalt na de timeout
    Click    button#niet-bestaande-knop