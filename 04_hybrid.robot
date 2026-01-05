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
    ${cookie_value}=    Set Variable    ${response.cookies['rack.session']}

    # 2. Browser Voorbereiden
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    # Maak een verse browseromgeving aan

    # 3. Het "Magische" moment: Het cookie injecteren
    # Hierdoor denkt de browser dat we al zijn ingelogd
    Add Cookie    name=rack.session    
    ...           value=${cookie_value}    
    ...           domain=the-internet.herokuapp.com    
    ...           path=/

    # 4. Navigeer direct naar de beveiligde pagina
    New Page       ${BASE_URL}/secure
    
    # 5. Verificatie: We moeten nu direct "Secure Area" zien
    Get Text       h2    contains    Secure Area
    Log            Succes! De browser is ingelogd zonder dat we de login-pagina hebben gebruikt.