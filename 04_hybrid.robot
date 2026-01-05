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

    # 3. Belangrijk: Open eerst de site (hoofdpagina) 
    # De browser moet op het domein zijn voordat hij een cookie accepteert
    New Page       ${BASE_URL}

    # 4. Het cookie injecteren
													   
    Add Cookie     name=rack.session    
    ...            value=${cookie_value}    
    ...            domain=the-internet.herokuapp.com    
    ...            path=/

    # 5. Nu pas naar de beveiligde pagina gaan
    Go To          ${BASE_URL}/secure
    
    # 6. Verificatie: Eerst wachten, dan pas checken
												
    Wait For Elements State    text=Secure Area    visible    timeout=10s
    Get Text    h2    contains    Secure Area
    Log         Succes! De browser is ingelogd via de API sessie..