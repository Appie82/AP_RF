*** Settings ***
Library    Browser

*** Variables ***
# Verander True naar False als je de browser weer wilt zien tijdens het testen
${HEADLESS}    True
${URL}         https://the-internet.herokuapp.com/login

*** Test Cases ***
Succesvol Inloggen Op Oefensite
    # 1. Start de browser op basis van onze variabele
    New Browser    browser=chromium    headless=${HEADLESS}
    New Page       ${URL}
    
    # 2. Gebruikersnaam en wachtwoord invullen
    Fill Text      id=username    tomsmith
    Fill Text      id=password    SuperSecretPassword!
    
    # 3. Klik op de Login knop
    Click          button[type="submit"]
    
    # 4. Controleren of we op de juiste pagina zijn
    Get Text       h2    contains    Secure Area
    
    # 5. Bevestigen dat de succesmelding er staat
    Get Text       id=flash    contains    You logged into a secure area!
    
    # Altijd een screenshot maken als bewijs, ook in headless mode
    Take Screenshot

Foutmelding Bij Verkeerd Wachtwoord
    # We hoeven niet opnieuw 'New Browser' te doen als we in dezelfde run zitten, 
    # maar 'New Page' zorgt voor een frisse start.
    New Page       ${URL}
    
    Fill Text      id=username    verkeerde_gebruiker
    Fill Text      id=password    fout_wachtwoord
    Click          button[type="submit"]
    
    # Controleer de foutmelding
    Get Text       id=flash    contains    Your username is invalid!
    
    Take Screenshot