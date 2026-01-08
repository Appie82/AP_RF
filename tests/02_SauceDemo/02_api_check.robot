*** Settings ***
Library         RequestsLibrary
Library         Collections

*** Test Cases ***
Scenario 24: API Health Check SauceDemo
    [Documentation]    Controleert of de server van de webshop online is via de API.
    [Tags]             api    smoke
    Create Session     sauce_api    https://www.saucedemo.com
    ${response}=       GET On Session    sauce_api    /
    Should Be Equal As Strings    ${response.status_code}    200