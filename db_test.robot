*** Settings ***
Library           DatabaseLibrary
Suite Setup       Connect To Database    sqlite3    mijn_nieuwe_db.db
# 1. OPSCHONEN: De Teardown zorgt dat we altijd netjes afsluiten
Suite Teardown    Schoonmaak En Afsluiten

*** Variables ***
${DB_BESTAND}       mijn_nieuwe_db.db
# 2. LIJSTEN: Een lijst met producten om te testen
@{PRODUCT_LIJST}    Laptop    Telefoon    Monitor    Toetsenbord

*** Test Cases ***
Test Meerdere Producten Via Loop
    [Documentation]    Voegt een lijst met producten toe en controleert ze één voor één.
    
    # Database voorbereiden
    Execute Sql String    DROP TABLE IF EXISTS producten;
    Execute Sql String    CREATE TABLE producten (id INTEGER PRIMARY KEY, naam TEXT, prijs REAL);
    
    # 3. DE LOOP: Voor elk product in onze lijst...
    FOR    ${product}    IN    @{PRODUCT_LIJST}
        Log    Bezig met testen van: ${product}
        Execute Sql String    INSERT INTO producten (naam, prijs) VALUES ('${product}', 100.00);
        # Controleren of het specifiek toegevoegde product bestaat
        Check Row Count       SELECT id FROM producten WHERE naam = '${product}'    ==    1
    END

Controleer Totaal Aantal
    [Documentation]    Checkt of alle 4 de producten uit de lijst in de DB staan.
    Check Row Count       SELECT id FROM producten    ==    4

*** Keywords ***
Schoonmaak En Afsluiten
    [Documentation]    Dit keyword ruimt de tabel op en sluit de verbinding.
    Log    De test is klaar, we ruimen de tabel 'producten' op.
    Execute Sql String    DROP TABLE IF EXISTS producten;
    Disconnect From Database