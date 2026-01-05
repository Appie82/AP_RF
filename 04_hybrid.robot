*** Settings ***
Resource    common.resource
Library     RequestsLibrary
Library     Browser

*** Test Cases ***
Snel Inloggen Via API En Verifiëren In Browser
    [Documentation]    Log in via de backend en geef het cookie door aan de browser om de login-pagina over te slaan.
    
    # 1. API Login: We schieten direct op de backend
    Create Session    auth_session    ${BASE_URL}    verify=True
    ${auth_data}=     Create Dictionary    username=${VALID_USER}    password=${VALID_PW}
    ${response}=      POST On Session    auth_session    url=/authenticate    data=${auth_data}
    
    # Haal het sessie-cookie (rack.session) uit de API response
    ${cookie_value}=  Set Variable    ${response.cookies['rack.session']}

    # 2. Browser Voorbereiden
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    # Verse omgeving

    # 3. Open de login pagina zodat de browser op het juiste domein is
    New Page       ${BASE_URL}/login

    # 4. Het cookie injecteren met de URL parameter
    # Dit is de meest betrouwbare methode voor Playwright/Browser library
    Add Cookie     name=rack.session    
    ...            value=${cookie_value}    
    ...            url=${BASE_URL}
    ...            path=/

    # 5. Refresh of navigeer naar de secure pagina
    Go To          ${BASE_URL}/secure
    
    # 6. Verificatie
    Wait For Elements State    css=h2    visible    timeout=10s
    Get Text    css=h2    contains    Secure Area

    # Extra check: controleer of de groene succes-bar er is
    Get Text    css=.flash.success    contains    You logged into a secure area!