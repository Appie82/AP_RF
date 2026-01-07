*** Settings ***
Library         Browser          # <--- Voeg dit hier direct toe
Resource        ../../common.resource
Suite Setup     New Browser    browser=${BROWSER}    headless=${HEADLESS}
Suite Teardown  Close Browser


*** Test Cases ***
Scenario 13: Hybride Sessie Injectie
    New Browser    browser=chromium    headless=False
    New Context
    New Page       ${BASE_URL}
    # PAS DAN het keyword uit de resource aanroepen:
    Maak Gebruiker Klaar En Injecteer Sessie    admin@test.nl    Password123