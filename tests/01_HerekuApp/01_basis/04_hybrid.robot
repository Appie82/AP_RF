Logt in via een API-request om een sessie-cookie te verkrijgen 
en controleert daarna in de browser 
of de gebruiker direct is ingelogd zonder het formulier te gebruiken.

*** Settings ***
Resource    ../../../common.resource
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
    
    # 2. Browser Voorbereiden
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    
    # 3. Open de pagina en wacht tot deze echt geladen is
    New Page       ${BASE_URL}/login
    # Wacht tot de browser zegt dat de pagina klaar is
    Wait For Load State    networkidle    timeout=15s

    # 4. Inloggen via de browser
    # We gebruiken een iets specifiekere selector voor de zekerheid
    Wait For Elements State    css=input#username    visible    timeout=10s
    Fill Text      css=input#username    ${VALID_USER}
    Fill Secret    css=input#password    $VALID_PW
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