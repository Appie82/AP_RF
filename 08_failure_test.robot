*** Settings ***
Resource    common.resource

*** Test Cases ***
Test Die Moet Falen Voor Screenshot
    [Documentation]    Dwingt een fout af voor een screenshot zonder te pauzeren.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}/login
    
    Set Browser Timeout    5s
    
    # We vangen de error af zodat de testrunner niet crasht, 
    # maar de library maakt nog steeds automatisch de screenshot.
    Run Keyword And Ignore Error    Click    button#niet-bestaande-knop
    
    # Optioneel: handmatig een extra screenshot ter bevestiging
    Take Screenshot    geplande-fout-screenshot