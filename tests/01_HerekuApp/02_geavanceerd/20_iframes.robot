Nesting Validatie. Gebruikt de >>> selector om in een geneste website (iFrame) te stappen, 
bijvoorbeeld om tekst te typen in een tekstverwerker zoals TinyMCE.

*** Settings ***
Resource          ../../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       ${BASE_URL}/tinymce
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 20: Tekst Typen In Een Iframe
    [Documentation]    Gebruik Evaluate JavaScript op het specifieke element binnen het iframe.
    [Tags]    iframe
    
    # 1. Wacht tot het iframe en de body geladen zijn
    Wait For Elements State    id=mce_0_ifr >>> id=tinymce    visible    timeout=10s
    
    # 2. Gebruik Evaluate JavaScript DIRECT op de selector
    # Het argument 'element' in het script verwijst naar de selector die we ervoor zetten
    Evaluate JavaScript    id=mce_0_ifr >>> id=tinymce    (element) => element.innerHTML = 'Hallo Appie, de 20 tests zijn compleet!'

    # 3. Verificatie
    Get Text     id=mce_0_ifr >>> id=tinymce    ==    Hallo Appie, de 20 tests zijn compleet!
