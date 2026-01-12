*** Settings ***
Resource        ../../../common.resource
Library         DataDriver    file=../../resources/data/testdata.csv
Test Setup      Start Test-Sessie    ${HEROKU_URL}/login
Test Teardown   Stop Test-Sessie
Test Template   Inloggen Met Ongeldige Data Zou Moeten Falen

*** Variables ***
${username}      ${EMPTY}
${password}      ${EMPTY}
${foutmelding}   ${EMPTY}

*** Test Cases ***
Inloggen met data uit bestand

*** Keywords ***
Inloggen Met Ongeldige Data Zou Moeten Falen
    [Arguments]    ${username}    ${password}    ${foutmelding}
    Fill Text    id=username    ${username}
    Fill Text    id=password    ${password}
    Click        button[type="submit"]
    Browser.Get Text     id=flash    contains    ${foutmelding}