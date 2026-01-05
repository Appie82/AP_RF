*** Settings ***
Resource    ../common.resource

*** Variables ***
${API_BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Haal Gebruiker Op Via API
    [Documentation]    Test of we gebruikersdata kunnen ophalen zonder browser.
    Create Session    alias=json_api    url=${API_BASE_URL}
    
    # We sturen een GET verzoek naar /users/1
    ${response}=    GET On Session    alias=json_api    url=/users/1
    
    # Controleer of de server '200 OK' antwoordt
    Status Should Be    200    ${response}
    
    # Controleer of de naam van de gebruiker klopt in de data
    Log    De naam is: ${response.json()['name']}
    Should Be Equal As Strings    Leanne Graham    ${response.json()['name']}

Controleer Of Post Wordt Aangemaakt
    [Documentation]    Test of we data kunnen 'sturen' naar de API.
    Create Session    alias=json_api    url=${API_BASE_URL}
    ${data}=          Create Dictionary    title=Robot Test    body=Dit is een API test    userId=1
    
    ${response}=    POST On Session    alias=json_api    url=/posts    json=${data}
    
    Status Should Be    201    ${response}
    Log    Response ID: ${response.json()['id']}