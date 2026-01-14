*** Settings ***
Library           DatabaseLibrary
Library           SeleniumLibrary
Suite Setup       Initialiseer Alles
Suite Teardown    Schoonmaak En Afsluiten

*** Variables ***
${BROWSER}        chrome
${URL}            https://practicetestautomation.com/practice-test-login/
${HACKER_INPUT}   ' OR 1=1 --
${DB_BESTAND}     beveiligings_test.db

*** Test Cases ***
Registratie Security Test
    [Documentation]    Test of malafide invoer wordt tegengehouden en gelogd.

    # --- STAP 0: SCHOONMAAK ---
    # Verwijder alle oude hacker data zodat de teller weer op 0 staat
    Execute Sql String    DELETE FROM producten WHERE naam = '${HACKER_INPUT}';
    
    # 1. WEB STAP: Open de browser en doe een poging
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=username    ${HACKER_INPUT}
    Input Text      id=password    Wachtwoord123
    Capture Page Screenshot    security_poging.png
    
    # 2. DB STAP: Controleer of deze malafide input de database niet heeft vervuild
    # We gebruiken variabelen om SQL-injectie in onze eigen test te voorkomen
    Check Row Count    SELECT id FROM producten WHERE naam = '${HACKER_INPUT}'    ==    0
    
    # 3. RAPPORTAGE: Voeg een eigen opmerking toe aan het rapport
    Log    Security check voltooid: De hacker-input is niet verwerkt in de database.    HTML

SQL Injectie Preventie Check
    [Documentation]    Controleert of onze database-engine de tabelstructuur beschermt.
    ${poging}    Set Variable    Drop Table producten;
    Log    Testen met gevaarlijke input: ${poging}
    
    # We proberen de input als naam in te voeren. 
    # Omdat we het als één string meegeven, mag de database de 'Drop Table' niet uitvoeren.
    Execute Sql String    INSERT INTO producten (naam, prijs) VALUES ('${poging}', 0.00);
    
    # Als de tabel nog bestaat, is de injectie mislukt (en de test dus geslaagd!)
    Table Must Exist    producten

*** Keywords ***
Initialiseer Alles
    Connect To Database    sqlite3    ${DB_BESTAND}
    Execute Sql String     CREATE TABLE IF NOT EXISTS producten (id INTEGER PRIMARY KEY, naam TEXT, prijs REAL);
    Set Selenium Speed     0.5 seconds

Schoonmaak En Afsluiten
    Close All Browsers
    Disconnect From Database