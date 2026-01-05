*** Settings ***
Resource    common.resource
Library     RequestsLibrary
Library     Browser

*** Test Cases ***
Snel Inloggen Via API En Verifiëren In Browser
    [Documentation]    Log in via de backend en geef het cookie door aan de browser om de login-pagina over te slaan.
    
# 1. API Login
    Create Session    auth_session    ${BASE_URL}    verify=True
    ${auth_data}=     Create Dictionary    username=${VALID_USER}    password=${VALID_PW}
    
    # Gebruik 'data=' voor form-encoded data (wat de login pagina verwacht)
    # Zorg dat je RequestsLibrary versie up-to-date is
    ${response}=      POST On Session    auth_session    url=/authenticate    data=${auth_data}

    # 2. Browser Voorbereiden
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    # Belangrijk: Geen extra opties hier
    
    # 3. Ga naar de login pagina (om op het domein te komen)
    New Page       ${BASE_URL}/login

    # 4. Cookie injecteren - We proberen de meest simpele vorm
    Add Cookie     name=rack.session    value=${cookie_value}    domain=the-internet.herokuapp.com    path=/

    # 5. Navigeer en REFRESH
    Go To          ${BASE_URL}/secure
    Reload         # Dwingt de browser het zojuist geplakte cookie te lezen
    
    # 6. Verificatie
    Wait For Elements State    css=h2    visible    timeout=10s

    # Extra check: controleer of de groene succes-bar er is
    Get Text    css=.flash.success    contains    You logged into a secure area!