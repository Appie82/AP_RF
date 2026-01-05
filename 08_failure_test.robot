*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Dwingt een fout af voor een screenshot zonder te pauzeren.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login
    
    Set Browser Timeout    5s
    
    # We negeren de error zodat de test netjes afsluit, 
    # maar het screenshot wordt nog steeds gemaakt bij de foute klik.
    Run Keyword And Ignore Error    Click    button#niet-bestaande-knop
    
    Take Screenshot    geplande-fout-screenshot