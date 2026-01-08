Synchronisatie-test. Navigeert naar de /dynamic_loading/2 pagina, 
klikt op start en gebruikt Wait For Elements State om tot 10s te wachten 
op de tekst "Hello World!". 
Dit voorkomt het gebruik van onbetrouwbare Sleep commando's.

*** Settings ***
Resource    ../../../common.resource

*** Test Cases ***
Wachten Op Dynamisch Element
    [Documentation]    Test hoe we omgaan met elementen die traag laden (geen Sleep gebruiken!).
    Open Browser    ${BASE_URL}/dynamic_loading/2    headless=${HEADLESS}
    
    # We klikken op start
    Click    button >> text=Start
    
    # We wachten maximaal 10 seconden tot de tekst 'Hello World!' echt zichtbaar is
    Wait For Elements State    text=Hello World!    visible    timeout=10s
    
    ${bericht}=    Get Text    id=finish
    Should Be Equal    ${bericht}    Hello World!