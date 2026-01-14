*** Settings ***
Resource          ../../../common.resource
Library           RequestsLibrary
Library           Browser
Documentation     Geavanceerde hybride test: Valideert sessie-overdracht tussen Browser en API.

*** Test Cases ***
Snel Inloggen Via API En Verifiëren In Browser
    [Documentation]    Inloggen via de UI en de verkregen sessie-cookie hergebruiken 
    ...                voor een geautoriseerde API-aanroep (Status 200 check).
    
    # STAP 1: Browser Initiëren & UI Login
    # We starten een nieuwe sessie en voeren een reguliere login uit.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}/login
    
    # Wachten tot de pagina stabiel is (networkidle) voor betrouwbare interactie
    Wait For Load State    networkidle    timeout=15s
    
    # Gebruik specifieke CSS-selectors voor robuuste navigatie
    Wait For Elements State    css=input#username    visible    timeout=10s
    Fill Text      css=input#username    ${VALID_USER}
    Fill Secret    css=input#password    $VALID_PW
    Click          css=button[type="submit"]

    # STAP 2: UI Verificatie
    # Controleer of we op de 'Secure Area' terecht zijn gekomen.
    Wait For Elements State    css=.flash.success    visible    timeout=10s
    Browser.Get Text    h2    contains    Secure Area
    Take Screenshot     success-login

    # STAP 3: Cookie Extractie (De 'Hybride' stap)
    # We halen de actieve cookies op uit de browser-context.
    ${browser_cookies}=    Get Cookies
    # De sessie-id (vaak 'rack.session') bevindt zich in de waarde van de cookie.
    ${session_value}=      Set Variable    ${browser_cookies[0].value}
    
    # STAP 4: API Validatie met Browser-Sessie
    # We maken een API-sessie aan en 'injecteren' de cookie uit de browser.
    Create Session    api_check    ${BASE_URL}    verify=True
    ${cookies_dict}=  Create Dictionary    rack.session=${session_value}
    
    # We roepen een beveiligde URL aan via de API met de browser-cookie.
    # Als de cookie geldig is, antwoordt de server met 200 OK.
    ${response}=      GET On Session    api_check    url=/secure    cookies=${cookies_dict}
    Status Should Be    200