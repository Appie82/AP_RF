*** Settings ***
Resource          ../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       ${BASE_URL}
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 17: Visuele Controle En Styling
    [Documentation]    Test of de pagina visueel correct is en specifieke stijlen heeft.
    [Tags]    visual

    # Stap 1: Maak een screenshot van de volledige pagina
    # Deze komt in de 'browser/screenshot' map in je results terecht
    Take Screenshot    fullPage=True

    # Stap 2: Controleer de kleur van de hoofdtitel (H1)
    # De Browser Library kan direct CSS-eigenschappen uitlezen
    # rgb(34, 34, 34) is de standaard tekstkleur op deze site
    Get Style    h1    color    ==    rgb(34, 34, 34)

    # Stap 3: Controleer of de footer onderaan de pagina staat
    Get Element States    id=page-footer    contains    visible