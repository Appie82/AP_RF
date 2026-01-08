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
    Get Text           .title    ==    Products
    Get Element Count  .inventory_item    >    5

Scenario 22: Sorteren op Prijs (Low to High)
    [Documentation]    Valideert of de sorteerfunctie van de webshop daadwerkelijk werkt.
    [Tags]             sauce    regressie
    Fill Text          id=user-name    standard_user
    Fill Text          id=password     secret_sauce
    Click              id=login-button
    
    # Selecteer sortering
    Select Options By  .product_sort_container    value    lohi
    
    # Check of het eerste product inderdaad de laagste prijs heeft ($7.99)
    Get Text           css=.inventory_item_price >> nth=0    ==    $7.99

Scenario 23: Volledige Checkout Flow
    [Documentation]    Doorloopt het hele proces van mandje tot finish.
    [Tags]             sauce    e2e
    Fill Text          id=user-name    standard_user
    Fill Text          id=password     secret_sauce
    Click              id=login-button
    
    # Voeg product toe en ga naar mandje
    Click              id=add-to-cart-sauce-labs-backpack
    Click              .shopping_cart_link
    Click              id=checkout
    
    # Vul gegevens in
    Fill Text          id=first-name    Test
    Fill Text          id=last-name     User
    Fill Text          id=postal-code   1234AB
    Click              id=continue
    
    # Afronden
    Click              id=finish
    Get Text           .complete-header    ==    Thank you for your order!