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

    # 5. Navigeer naar de beveiligde pagina
    Go To    ${BASE_URL}/secure
    
    # 6. Verificatie: Wees specifiek door de HTML-tag (h2) te gebruiken
    # Dit voorkomt dat hij de 'flash' melding of andere teksten pakt
    Wait For Elements State    css=h2 >> text="Secure Area"    visible    timeout=10s
    
    # Extra check: controleer of de groene succes-bar er is
    Get Text    css=.flash.success    contains    You logged into a secure area!