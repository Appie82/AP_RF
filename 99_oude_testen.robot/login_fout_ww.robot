*** Settings ***
Library    Browser

*** Test Cases ***
Foutmelding Bij Verkeerd Wachtwoord
    New Page       https://the-internet.herokuapp.com/login
    
    # Vul een verkeerde combinatie in
    Fill Text      id=username    verkeerde_gebruiker
    Fill Text      id=password    fout_wachtwoord
    Click          button[type="submit"]
    
    # Controleer of de rode foutmelding verschijnt
    # De ID 'flash' wordt ook gebruikt voor foutmeldingen
    Get Text       id=flash    contains    Your username is invalid!
    
    # Check of de tekst rood is (optioneel, voor de pro's)
    Get Style      id=flash    background-color    contains    rgb(198, 15, 19)
    
    Take Screenshot