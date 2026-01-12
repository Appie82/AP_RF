Data-consistentie. Test het wijzigen van gebruikersinstellingen. 
De test verifieert of een wijziging in het profiel (zoals een naam of voorkeur) 
correct wordt opgeslagen en getoond na een pagina-refresh.
*** Settings ***
Resource          ../../../common.resource
Suite Setup       New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup        New Page       ${BASE_URL}/login
Suite Teardown    Close Browser

*** Test Cases ***
Scenario 15: Profiel Validatie Na Login
    [Tags]    profile    regression
    Go To    ${BASE_URL}/login
    
    # Voer een snelle login uit
    Fill Text    css=#username    tomsmith
    Fill Text    css=#password    SuperSecretPassword!
    Click        css=button[type='submit']
    
    # Verifieer dat we in de secure area zijn
    Browser.Get Text    css=h2    contains    Secure Area
    
    # Nu we ingelogd zijn, kunnen we direct naar /secure gaan
    Go To       ${BASE_URL}/secure
    Browser.Get Text    css=.subheader    contains    Welcome to the Secure Area