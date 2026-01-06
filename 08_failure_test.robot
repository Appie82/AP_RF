*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Dwingt een fout af zonder dat de CI-server blijft hangen.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login
    
    # We zetten de timeout kort voor de test
    Set Browser Timeout    5s
    
    # DOOR DIT KEYWORD TE GEBRUIKEN VOORKOMEN WE DE PAUZE:
    # We 'vangen' de error op voordat de library de kans krijgt om te pauzeren.
    Run Keyword And Ignore Error    Click    button#niet-bestaande-knop
    
    # Nu maken we handmatig het screenshot, omdat de automatische faalt door de 'ignore'
    Take Screenshot    failure-screenshot-geforceerd
    
    # We laten de test alsnog falen voor het rapport, maar zonder de EOFError
    Fail    De knop was niet aanwezig zoals verwacht (geplande fout).