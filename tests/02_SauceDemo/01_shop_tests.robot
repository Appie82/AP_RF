*** Settings ***
Resource        ../../common.resource
Test Setup      Start Test-Sessie    ${SAUCE_URL}
Test Teardown   Stop Test-Sessie

*** Test Cases ***
Scenario 21: Succesvolle Inlog en Product Check
    [Documentation]    Controleert of een standaard gebruiker kan inloggen en de titels ziet.
    [Tags]             sauce    smoke
    Fill Text          id=user-name    standard_user
    Fill Text          id=password     secret_sauce
    Click              id=login-button
    Browser.Get Text           .title    ==    Products
    Get Element Count  .inventory_item    >    5

Scenario 22: Sorteren op Prijs en Validatie
    [Documentation]    Controleert of de sortering van laag naar hoog correct werkt.
    [Tags]             sauce    regressie
    
    # Inloggen
    Fill Text          id=user-name    standard_user
    Fill Text          id=password     secret_sauce
    Click              id=login-button
    
    # Selecteer de sorteeroptie 'Price (low to high)'
    # De 'value' lohi staat voor Low to High
    Select Options By  .product_sort_container    value    lohi
    
    # Haal de prijzen op van de eerste twee producten
    ${prijs_1}    Browser.Get Text    css=.inventory_item_price >> nth=0
    ${prijs_2}    Browser.Get Text    css=.inventory_item_price >> nth=1
    
    # Log de prijzen voor je rapport
    Log    Eerste product: ${prijs_1}, Tweede product: ${prijs_2}
    
    # Validatie: De eerste prijs moet $7.99 zijn bij deze site
    Should Be Equal    ${prijs_1}    $7.99

Scenario 23: Volledige Checkout Flow (Master)
    [Documentation]    Doorloopt het hele proces van inloggen tot orderbevestiging.
    [Tags]             sauce    e2e    critical
    
    # 1. Inloggen
    Fill Text          id=user-name    standard_user
    Fill Text          id=password     secret_sauce
    Click              id=login-button
    
    # 2. Product selecteren en toevoegen
    Click              id=add-to-cart-sauce-labs-backpack
    Browser.Get Text           .shopping_cart_badge    ==    1
    
    # 3. Naar winkelwagen
    Click              .shopping_cart_link
    Browser.Get Text           .inventory_item_name    ==    Sauce Labs Backpack
    Click              id=checkout
    
    # 4. Verzendgegevens invullen
    Fill Text          id=first-name    Appie
    Fill Text          id=last-name     Tester
    Fill Text          id=postal-code   1234AB
    Click              id=continue
    
    # 5. Overzicht controleren en afronden
    Browser.Get Text           .summary_subtotal_label    contains    29.99
    Click              id=finish
    
    # 6. Bevestiging
    Browser.Get Text           .complete-header    ==    Thank you for your order!
    Browser.Get Element States     .pony_express       contains    visible