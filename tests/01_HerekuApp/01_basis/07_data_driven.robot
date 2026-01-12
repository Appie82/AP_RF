*** Settings ***
Library    Browser
Resource   ../../../common.resource
Library    DataDriver    file=C:/Users/alber/RF/resources/data/testdata.csv    delimiter=;

Test Template    Inloggen Met Data
Suite Setup      Start Test-Sessie
Suite Teardown   Stop Test-Sessie

*** Variables ***
${username}      ${EMPTY}
${password}      ${EMPTY}
${foutmelding}   ${EMPTY}

*** Test Cases ***
Inloggen met data uit bestand    ${username}    ${password}    ${foutmelding}

*** Keywords ***
Inloggen Met Data
    [Arguments]    ${username}    ${password}    ${foutmelding}
    Go To          ${HEROKU_URL}/login
    Fill Text    id=username    ${username}
    Fill Text    id=password    ${password}
    Click        button[type="submit"]
    Browser.Get Text     id=flash    contains    ${foutmelding}