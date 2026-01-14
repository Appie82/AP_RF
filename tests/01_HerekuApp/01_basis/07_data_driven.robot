*** Settings ***
Library           Browser
Resource          ../../../common.resource
# De DataDriver library koppelt elke regel uit de CSV aan een nieuwe test-iteratie
Library           DataDriver    file=C:/Users/alber/RF/resources/data/testdata.csv    delimiter=;

Test Template     Inloggen Met Data
Suite Setup       Start Test-Sessie
Suite Teardown    Stop Test-Sessie

*** Variables ***
# Deze variabelen dienen als placeholders die door de DataDriver worden overschreven
${username}       ${EMPTY}
${password}       ${EMPTY}
${foutmelding}    ${EMPTY}

*** Test Cases ***
Scenario 11: Inloggen met data uit bestand    ${username}    ${password}    ${foutmelding}
    [Documentation]    Voert een inlogpoging uit voor elke rij in het gekoppelde CSV-bestand.

*** Keywords ***
Inloggen Met Data
    [Arguments]    ${username}    ${password}    ${foutmelding}
    [Documentation]    De kern-logica die wordt herhaald voor elke dataset uit de CSV.
    
    # 1. Navigatie
    Go To          ${HEROKU_URL}/login
    
    # 2. Interactie: De waarden ${username} en ${password} komen rechtstreeks uit de kolommen van de CSV
    Fill Text      id=username    ${username}
    Fill Text      id=password    ${password}
    Click          button[type="submit"]
    
    # 3. Validatie: We controleren de 'flash' melding op de pagina tegen de verwachte foutmelding uit de CSV
    Browser.Get Text     id=flash    contains    ${foutmelding}
    
    Log    Data-driven run succesvol voor gebruiker: ${username}