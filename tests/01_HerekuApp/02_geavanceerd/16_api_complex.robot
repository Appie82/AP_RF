Geavanceerde Backend Test. Waar test 03 simpel was, gaat deze dieper: 
het verifiëren van complexe geneste JSON-objecten, het controleren van headers en het werken met autorisatie-tokens.
*** Settings ***
Resource          ../../../common.resource

*** Test Cases ***
Scenario 16: Volledige API Lifecycle
    [Tags]    api
    Create Session    mysession    https://jsonplaceholder.typicode.com
    
    # 1. Product aanmaken
    ${body}=    Create Dictionary    title=FerryTest    body=Testen is leuk    userId=1
    ${post_res}=    POST On Session    mysession    /posts    json=${body}
    Should Be Equal As Strings    ${post_res.status_code}    201
    
    # 2. ID ophalen uit de vorige stap
    ${new_id}=    Set Variable    ${post_res.json()['id']}
    Log    Nieuw item heeft ID: ${new_id}