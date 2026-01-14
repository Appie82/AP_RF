*** Settings ***
Resource         ../../../common.resource
Documentation    Validatie van dynamische content-opbouw en tabel-interactie.
Test Teardown    Sluit Test En Maak Screenshot Bij Fout

*** Test Cases ***
Wachten Op Dynamische Content
    [Documentation]    Valideert de stabiliteit van de test bij AJAX-aanroepen. 
    ...                Voorkomt crashes door dynamisch te wachten in plaats van statische pauzes.
    
    # 1. Browser initialisatie met globale variabelen uit common.resource
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${DYNAMIC_URL}
    
    # 2. Trigger de AJAX-actie
    Click          button >> text=Start
    
    # 3. Synchronisatie-stap: We wachten tot het element 'visible' wordt. 
    # De test gaat direct verder zodra de tekst verschijnt (max 10s).
    Wait For Elements State    text=Hello World!    visible    timeout=10s
    Browser.Get Text           text=Hello World!    ==         Hello World!

Zoek Waarde In Dynamische Tabel
    [Documentation]    Demonstreert het itereren door een HTML-tabel om specifieke data te valideren.
    
    # Navigatie naar de tabel-pagina
    New Page       ${TABEL_URL}
    
    # STAP 1: Haal alle rij-elementen op uit de tbody van de tabel
    ${rijen}=      Get Elements    table >> tbody >> tr
    
    # STAP 2: Loop door de rijen om de gewenste waarde te vinden
    # Dit is veiliger dan een hardcoded index omdat rijen kunnen verschuiven.
    FOR    ${rij}    IN    @{rijen}
        # Haal tekst op uit de tweede kolom (td:nth-child(2)) van de huidige rij
        ${tekst}=    Browser.Get Text    ${rij} >> td:nth-child(2)
        
        # STAP 3: Conditionele validatie
        IF    "Apeirian" in "${tekst}"
            Log             Gevonden resultaat: ${tekst}
            # Maak een gerichte screenshot van alleen de relevante rij
            Take Screenshot    selector=${rij}
            BREAK           # Stop de loop zodra de waarde is gevonden (efficiëntie)
        END
    END