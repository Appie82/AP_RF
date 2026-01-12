Besturingssysteem Interactie. 
Gebruikt ${CURDIR} om een lokaal bestand aan te maken en dit via de browser te uploaden. 
Verifieert of de server de ontvangst bevestigt met "File Uploaded!".

*** Settings ***
Resource          ../../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       ${BASE_URL}/upload
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 18: Succesvol Een Bestand Uploaden
    [Documentation]    Test of een lokaal bestand naar de server kan worden gestuurd.
    [Tags]    upload
    
    # We gebruiken ${CURDIR} om het pad naar dit script te vinden
    # We uploaden de 'common.resource' als testbestand
    Upload File By Selector    css=#file-upload    ${CURDIR}/../../../common.resource
    
    Click    id=file-submit
    
    # Verificatie
    Browser.Get Text    css=h3    ==    File Uploaded!
    Browser.Get Text    id=uploaded-files    contains    common.resource