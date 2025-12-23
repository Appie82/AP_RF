*** Settings ***
Library    Browser

*** Test Cases ***
Mijn eerste webtest
    # Open de browser en ga naar de site
    New Browser    browser=chromium    headless=False
    New Page       https://www.google.com
    
    # Als er een cookie-melding komt, accepteren we die
    # We zoeken naar de knop met de tekst 'Alles accepteren'
    Click          text="Alles accepteren"
    
    # Zoek naar iets op de pagina om te controleren of het werkt
    Get Title      contains    Google
    
    # Maak een screenshot als bewijs
    Take Screenshot