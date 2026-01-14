*** Settings ***
Resource          ../../../common.resource
# De Teardown zorgt voor een screenshot als een van de rijen in de tabel faalt
Test Teardown     Sluit Test En Maak Screenshot Bij Fout
# De Test Template zorgt ervoor dat elke regel in de Test Cases als een aparte test wordt uitgevoerd
Test Template     Inloggen Met Verschillende Gegevens

*** Test Cases ***
# | Test Naam |                    Gebruikersnaam |    Wachtwoord |              Verwachte Tekst (Success of Error) |
Correcte Gegevens                  tomsmith            SuperSecretPassword!      Secure Area
Verkeerd Wachtwoord                tomsmith            FoutWachtwoord            Your password is invalid!
Onbekende Gebruiker                Alber123            SuperSecretPassword!      Your username is invalid!
Lege Velden                        ${EMPTY}            ${EMPTY}                  Your username is invalid!

*** Keywords ***
Inloggen Met Verschillende Gegevens
    [Documentation]    Dit keyword fungeert als de 'motor' voor de bovenstaande tabel.
    ...                Het voert de acties uit voor elke set gegevens die wordt meegegeven.
    [Arguments]        ${user}    ${pass}    ${check_tekst}
    
    # 1. Start de browser sessie voor deze specifieke data-set
    Open De Browser Op De Inlogpagina
    
    # 2. Voer de inlogpoging uit met de argumenten uit de tabel
    Log In Met Gebruiker    ${user}    ${pass}
    
    # 3. Verificatie: we checken de gehele body-tekst op de verwachte boodschap.
    # Dit werkt voor zowel succesmeldingen als foutmeldingen.
    Browser.Get Text    body    contains    ${check_tekst}
    
    Log    Validatie voltooid voor gebruiker: ${user} met verwachte tekst: ${check_tekst}