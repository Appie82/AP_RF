*** Settings ***
Library    Browser

*** Test Cases ***
Succesvol Inloggen Op Oefensite
    # 1. Open de browser op de loginpagina
    New Browser    browser=chromium    headless=False
    New Page       https://the-internet.herokuapp.com/login
    
    # 2. Vul de gebruikersnaam en wachtwoord in
    # De selectors 'id=username' en 'id=password' zijn uniek en stabiel
    Fill Text      id=username    tomsmith
    Fill Text      id=password    SuperSecretPassword!
    
    # 3. Klik op de Login knop
    Click          button[type="submit"]
    
    # 4. Controleer of we op de 'Secure Area' zijn beland
    Get Text       h2    contains    Secure Area
    
    # 5. Controleer of de groene succesmelding verschijnt
    Get Text       id=flash    contains    You logged into a secure area!
    
    Take Screenshot