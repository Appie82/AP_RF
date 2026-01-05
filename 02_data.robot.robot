*** Settings ***
Resource    ../common.resource
Documentation    Data-tests die gebruik maken van de centrale instellingen.
Test Teardown    Sluit Test En Maak Screenshot Bij Fout

*** Test Cases ***
Wachten Op Dynamische Content
    # We gebruiken de browser-instellingen uit de resource
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${DYNAMIC_URL}
    
    Click          button >> text=Start
    Wait For Elements State    text=Hello World!    visible    timeout=10s
    Get Text       text=Hello World!    ==    Hello World!

Zoek Waarde In Dynamische Tabel
    # We openen een nieuwe pagina in dezelfde browser
    New Page       ${TABEL_URL}
    
    ${rijen}=      Get Elements    table >> tbody >> tr
    
    FOR    ${rij}    IN    @{rijen}
        ${tekst}=    Get Text    ${rij} >> td:nth-child(2)
        
        IF    "Apeirian" in "${tekst}"
            Log    Gevonden: ${tekst}
            Take Screenshot    selector=${rij}
            BREAK
        END
    END