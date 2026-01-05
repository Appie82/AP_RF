*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Dwingt een fout af zonder de CI-server te laten hangen.
    
    # Forceer de browser om NIET te pauzeren bij fouten
    # Dit overschrijft eventuele debug-instellingen op de server
    Set Browser Timeout    5s
    
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    
    # Belangrijk: Maak een context aan ZONDER tracing of debug opties
    New Context    
    New Page       ${BASE_URL}/login
    
    # We gebruiken Run Keyword And Expect Error om de EOFError te voorkomen
    # Dit vangt de TimeoutError af voordat de library kan gaan 'pauzeren'
    Run Keyword And Expect Error    *Timeout 5000ms exceeded* ...    Click    button#niet-bestaande-knop
    
    # Omdat we de error verwachtten, gaat de test hierna door naar de screenshot
    Take Screenshot    geplande-fout-screenshot