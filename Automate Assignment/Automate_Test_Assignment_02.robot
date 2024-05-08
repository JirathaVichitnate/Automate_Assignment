*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}     http://the-internet.herokuapp.com/login
${USERNAME}      tomsmith
${CORRECT_PASSWORD}      SuperSecretPassword!
${INCORRECT_PASSWORD}    Password!
${INVALID_USERNAME}      tomholland

*** Test Cases ***
TC_001 Login Success
    [Documentation]    To verify that users can login successfully when input a correct username and password.
    ...     Test Steps
    ...     1. Open browser and go to 'http://the- internet.herokuapp. com/login'.
    ...     2. Input username 'tomsmith' and password 'SuperSecretPassword!'.
    ...     3. Click the 'Logout' button.
    ...     Expected Result
    ...     1. Login page is shown.
    ...     2. Login success and message 'You logged into a secure area!' is shown.
    ...     3. Go back to the Login page and the message ' You logged out of the secure area!' is shown.
    [Tags]  Test Case 1
    Open Browser    ${LOGIN_URL}    gc
    Maximize Browser Window
    Input Username And Password    ${USERNAME}    ${CORRECT_PASSWORD}
    Click Login Button
    Verify Successful Login
    Click Logout Button
    Verify Successful Logout
    Close Browser

TC_002 Login Failed - Password Incorrect
    [Documentation]    To verify that users can login unsuccessfully when they input a correct username but wrong password.
    ...     Test Steps
    ...     1. Open browser and go to 'http://the- internet.herokuapp. com/login'.
    ...     2. Input username 'tomsmith' and password 'Password!'.
    ...     Expected Result
    ...     1. Login page is shown.
    ...     2. Login failed and the message 'Your password is invalid!' is shown.
    [Tags]  Test Case 2
    Open Browser    ${LOGIN_URL}    Chrome
    Maximize Browser Window
    Input Username And Password    ${USERNAME}    ${INCORRECT_PASSWORD}
    Click Login Button
    Verify Password Incorrect Message
    Close Browser

TC_003 Login Failed - Username Not Found
    [Documentation]    To verify that users can login unsuccessfully when they input a username that did not exist.
    ...     Test Steps
    ...     1. Open browser and go to 'http://the- internet.herokuapp. com/login'.
    ...     2. Input username 'tomholland' and password 'Password!'.
    ...     Expected Result
    ...     1. Login page is shown.
    ...     2. Login failed and the message 'Your username is invalid!' is shown.
    [Tags]  Test Case 3
    Open Browser    ${LOGIN_URL}    Chrome
    Maximize Browser Window
    Input Username And Password    ${INVALID_USERNAME}    ${INCORRECT_PASSWORD}
    Click Login Button
    Verify Username Not Found Message

*** Keywords ***
Input Username And Password
    [Arguments]    ${username}    ${password}
    wait until keyword succeeds     30 s    1 s     element should be visible        id=username
    wait until keyword succeeds     30 s    1 s     element should be visible        id=password
    wait until keyword succeeds     30 s    1 s     Input Text    id=username    ${username}
    wait until keyword succeeds     30 s    1 s     Input Text    id=password    ${password}

Click Login Button
    wait until keyword succeeds     30 s    1 s     element should be visible    //button[@type="submit"]
    wait until keyword succeeds     30 s    1 s     Click Button    //button[@type="submit"]

Click Logout Button
    wait until keyword succeeds     30 s    1 s     element should be visible        //a[@class="button secondary radius"]//i
    wait until keyword succeeds     30 s    1 s     Click Element    //a[@class="button secondary radius"]//i
    

Verify Successful Login
    wait until keyword succeeds     30 s    1 s     element should be visible    //*[contains(text(),'You logged into a secure area!')]
    ${error_message}=    Get Text    //*[contains(text(),'You logged into a secure area!')]
    Should Contain    ${error_message}    You logged into a secure area!

Verify Successful Logout
    wait until keyword succeeds     30 s    1 s     element should be visible    //*[contains(text(),' You logged out of the secure area!')]
    ${error_message}=    Get Text    //*[contains(text(),' You logged out of the secure area!')]
    Should Contain    ${error_message}     You logged out of the secure area!

Verify Password Incorrect Message
    wait until keyword succeeds     30 s    1 s     element should be visible    //*[contains(text(),' Your password is invalid!')]
    ${error_message}=    Get Text    //*[contains(text(),' Your password is invalid!')]
    Should Contain    ${error_message}     Your password is invalid!

Verify Username Not Found Message
    Wait Until Page Contains Element    //*[contains(text(),'Your username is invalid!')]
    ${error_message}=    Get Text    //*[contains(text(),'Your username is invalid!')]
    Should Contain    ${error_message}    Your username is invalid!