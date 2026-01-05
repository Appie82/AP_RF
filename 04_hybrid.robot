*** Settings ***
Resource    common.resource
Library     RequestsLibrary
Library     Browser

*** Test Cases ***
Snel Inloggen Via API En Verifiëren In Browser
    [Documentation]    Log in via de browser en gebruik de sessie voor een API check.
    
    # 1. Start de browser en log in (gebruik je stabiele keyword)
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login
    
    # Gebruik de standaard login procedure
    Fill Text      id=username    ${VALID_USER}
    Fill Secret    id=password    $VALID_PW
    Click          css=button[type="submit"]
    
    # 2. Verifieer in de browser (Dit moet nu lukken)
    Wait For Elements State    css=.flash.success    visible    timeout=10s
    
    # 3. HYBRIDE STAP: Haal het cookie uit de browser en test de API
    ${browser_cookies}=    Get Cookies
    # We pakken het actieve cookie uit de browser om de API aan te roepen
    ${session_cookie}=     Set Variable    ${browser_cookies[0].value}
    
    # 4. Inloggen via de browser (met de juiste secret syntax)
    Fill Text      id=username    ${VALID_USER}
    Fill Secret    id=password    $VALID_PW  # Let op: geen { } hier!
    Click          css=button[type="submit"]

    # 5. Verificatie in de Browser
    Wait For Elements State    css=.flash.success    visible    timeout=10s
    Get Text    h2    contains    Secure Area
    Take Screenshot    success-login

    # 6. Hybride check: Gebruik browser sessie voor API
    ${browser_cookies}=    Get Cookies
    # We pakken de waarde van de eerste cookie (meestal rack.session)
    ${session_value}=      Set Variable    ${browser_cookies[0].value}
    
    Create Session    api_check    ${BASE_URL}    verify=True
    ${cookies_dict}=  Create Dictionary    rack.session=${session_value}
    
    # Controleer of de API de browser-sessie accepteert
    ${response}=      GET On Session    api_check    url=/secure    cookies=${cookies_dict}
    Status Should Be    200    ${response}
    Log    Hybride test geslaagd!