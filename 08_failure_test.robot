*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    # Hier zetten we de 'stop on failure' uit via een keyword
    Set Browser Timeout    5s
    # Gebruik dit keyword om de pauze te voorkomen:
    Set Strict Mode    False
    
    New Page       ${BASE_URL}/login
    Click          button#niet-bestaande-knop