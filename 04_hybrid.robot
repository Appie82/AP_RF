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
    Fill Secret    id=password    ${VALID_PW}
    Click          css=button[type="submit"]
    
    # 2. Verifieer in de browser (Dit moet nu lukken)
    Wait For Elements State    css=.flash.success    visible    timeout=10s
    
    # 3. HYBRIDE STAP: Haal het cookie uit de browser en test de API
    ${browser_cookies}=    Get Cookies
    # We pakken het actieve cookie uit de browser om de API aan te roepen
    ${session_cookie}=     Set Variable    ${browser_cookies[0].value}
    
    # 4. API Check: Gebruik de browser-sessie om data op te halen
    Create Session    auth_session    ${BASE_URL}    verify=True
    ${cookie_dict}=   Create Dictionary    rack.session=${session_cookie}
    ${response}=      GET On Session    auth_session    url=/secure    cookies=${cookie_dict}
    
    # 5. Verificatie in de Browser (Visueel)
    # We wachten specifiek op de groene succesmelding en de h2 kop
    Wait For Elements State    css=.flash.success    visible    timeout=10s
    Get Text    h2    contains    Secure Area
    
    # Maak een screenshot voor de zekerheid (zichtbaar in je artifacts)
    Take Screenshot    failure-check-step-5

    # 6. Hybride Verificatie (Technisch via API)
    # Nu we weten dat de browser er is, checken we of de API dit ook vindt
    ${browser_cookies}=    Get Cookies
    ${session_value}=      Set Variable    ${browser_cookies[0].value}
    
    Create Session    api_check    ${BASE_URL}    verify=True
    ${cookies_dict}=  Create Dictionary    rack.session=${session_value}
    
    # We doen een GET request naar de secure pagina met het browser-cookie
    ${response}=      GET On Session    api_check    url=/secure    cookies=${cookies_dict}
    
    # Als de status 200 is, is de sessie ook echt geldig voor de server
    Status Should Be    200    ${response}
    Log    Stap 6 geslaagd: API bevestigt dat de browser-sessie technisch valide is.

    # Extra check: controleer of de groene succes-bar er is
    Get Text    css=.flash.success    contains    You logged into a secure area!