*** Settings ***
Library    RequestsLibrary
Library    BuiltIn

*** Variables ***
${API_URL}    https://catfact.ninja/fact

*** Test Cases ***
Test API Endpoint
    [Documentation]    Test the API endpoint for expected response
    Create Session    mysession    ${API_URL}
    ${response}=    GET On Session    mysession    /    expected_status=200
    Log    "returned json:"
    Log    ${response.json()}
    ${json_data}=    Set Variable    ${response.json()}
    BuiltIn.Should Contain     ${json_data}    fact

*** Keywords ***
# Add any custom keywords if needed
