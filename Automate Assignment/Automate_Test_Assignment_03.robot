*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    json

*** Test Cases ***
TC_001 Get User Profile Success
    [Documentation]    To verify get user profile API will return correct data when trying to get profile of existing user
    ...     Test Steps
    ...     1. Send Get request to url https://reqres.in/ap i/users/12
    ...     Expected Result
    ...     1. Verify response status code should be ‘200’
    ...     2. Compare the response body with expected below.
    ...     ‘ID’ == 12
    ...     ‘Email’ == rachel.howell@reqres.in ‘First Name’ == Rachel
    ...     ‘Last Name’ == Howell
    ...     ‘Avatar’ == https://reqres.in/img/faces/12- image.jpg
    [Tags]    Test Case 1
    ${url}    Set Variable    https://reqres.in/api/users/12
    ${expected_body}    Create Dictionary    id=${12}    email=rachel.howell@reqres.in    first_name=Rachel    last_name=Howell    avatar=https://reqres.in/img/faces/12-image.jpg
    ${response}=    Get     ${url}
    Check Response Status Code    ${response}    200
    Check Response Body    ${response}    ${expected_body}

Get User Profile But User Not Found
    [Documentation]    To verify get user profile API will return 404 not found when trying to get profile of non-existing user
    ...     Test Steps
    ...     1. Send Get request to url https://reqres.in/ap i/users/1234
    ...     Expected Result
    ...     1. Verify response status code should be ‘404’.
    ...     2. Response body should be '{}'
    [Tags]    Test Case 2
    ${url}    Set Variable    https://reqres.in/api/users/1234
    ${response}=     Run Keyword And Expect Error    HTTPError: 404*    Get     ${url}
    Log     ${response} 
    Should Not Be Equal    ${response}    ${None}    msg=Expected an HTTPError but null of respond body

*** Keywords ***
Check Response Status Code
    [Arguments]    ${response}    ${expected_code}

    ${status_code}=    Convert To Integer    ${response.status_code}

    Should Be Equal As Numbers    ${status_code}    ${expected_code}

Check Response Status Code 2
    [Arguments]    ${response_content}    ${expected_code}
    ${response}=    Evaluate    ${response_content.json()}
    ${status_code}=    Convert To Integer    ${response['status_code']}
    Should Be Equal As Numbers    ${status_code}    ${expected_code}

Check Response Body
    [Arguments]    ${response}    ${expected_body}
    ${response_body}=    Convert To String    ${response.content}
    ${response_json}=    Evaluate    json.loads($response_body)
    ${response_json}    Set Variable    ${response_json["data"]}
    Log Many     ${response_json}    ${expected_body}
    Should Be Equal As Strings     ${response_json}    ${expected_body}