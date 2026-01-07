Moderne Webtechniek. Richt zich op elementen die verborgen zitten in een "Shadow Root" (veelgebruikt in modern JavaScript frameworks). 
Gebruikt de Browser Library om door deze isolatielaag heen te prikken.
*** Settings ***
Resource          ../../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       ${BASE_URL}/shadowdom
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 19: Tekst Lezen Uit Shadow DOM
    [Documentation]    Verifieer dat we elementen binnen een Shadow Root kunnen vinden.
    [Tags]    shadowdom
    
    # De Browser library vindt dit element automatisch, zelfs in de shadow root
    Get Text    css=span[slot="my-text"]    contains    Let's have some different text!
