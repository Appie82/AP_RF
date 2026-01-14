*** Settings ***
Resource         ../../../common.resource
Documentation    Directe interactie met REST-endpoints. Valideert business-logica 
...              zonder de overhead van een grafische interface (UI).

*** Variables ***
${API_BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Haal Gebruiker Op Via API
    [Documentation]    Valideert de GET-methode. We controleren of de database de 
    ...                juiste informatie teruggeeft voor een specifieke gebruiker.
    
    # 1. Verbinding maken met de server (sessie-beheer)
    Create Session    alias=json_api    url=${API_BASE_URL}
    
    # 2. Het GET verzoek versturen om data op te vragen
    ${response}=    GET On Session    alias=json_api    url=/users/1
    
    # 3. HTTP Protocol validatie: 200 betekent succesvolle overdracht
    Status Should Be    200    ${response}
    
    # 4. Data-extractie: We parsen het JSON-object om een specifieke waarde te checken
    Log    De opgehaalde naam uit de API is: ${response.json()['name']}
    Should Be Equal As Strings    Leanne Graham    ${response.json()['name']}

Controleer Of Post Wordt Aangemaakt
    [Documentation]    Valideert de POST-methode. We simuleren het insturen van nieuwe 
    ...                content en verwachten een '201 Created' statuscode.
    
    # 1. Opbouwen van de data-payload (het JSON-pakketje dat we versturen)
    ${data}=          Create Dictionary    title=Robot Test    body=Dit is een API test    userId=1
    
    # 2. De data versturen naar het /posts endpoint
    ${response}=    POST On Session    alias=json_api    url=/posts    json=${data}
    
    # 3. Validatie: De server bevestigt de creatie met code 201
    Status Should Be    201    ${response}
    
    # 4. Echo-check: We