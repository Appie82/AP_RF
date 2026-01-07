*** Settings ***
Resource          ../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       https://the-internet.herokuapp.com/login
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 14: Data Driven Product Search
    [Template]    Zoek En Verifieer Product
    laptop    laptop
    iphone    iphone
    camera    camera

*** Keywords ***
Zoek En Verifieer Product
    [Arguments]    ${zoekterm}    ${verwachte_tekst}
    # Hier vullen we het 'username' veld in als test
    Fill Text      css=#username    ${zoekterm}
    # We checken of de tekst in het veld is gekomen
    Get Property   css=#username    value    ==    ${verwachte_tekst}