*** Settings ***
Library           AppiumLibrary
Library           SeleniumLibrary
Suite Setup       Open App
Suite Teardown    Close Application

*** Variables ***
${APP_PATH}               /Users/jiratha/Documents/Automate/App/app-release.apk
${PLATFORM_NAME}          Android
${DEVICE_NAME}            emulator-5554
${PLATFORM_VERSION}       14
${APP_PACKAGE}            com.avjindersinghsekhon.minimaltodo
${APP_ACTIVITY}           .MainActivity

*** Test Cases ***
TC_001 Add Task
    [Documentation]    To verify the task functionalty.Task Creation
    ...     Test Steps
    ...     1. Open the application.
    ...     2. Verify the presence of the first screen.
    ...     3. Create a new task.
    ...     Expected Result
    ...     1. First page is shown.
    ...     2. Verify the new created task is displayed in the task list.
    [Tags]  Test Case 1
    Verify Open App ToDo
    # Add a new task
    Add Task    Sleep
    Add Task    Wake Up
    Add Task    Test

TC_002 Edit Task
    [Documentation]   To verify task management functionality.Task Edition
    ...     Test Steps
    ...     1. Select and enter the task that you created before
    ...     2. Change the task.
    ...     3. Resubmit.
    ...     Expected Result
    ...     1. Enter to the task page.
    ...     2. Can change the title of task.
    ...     3. Verify the new created task is displayed in the task list.
    [Tags]  Test Case 2

    Edit Task   Wake Up   Continue Sleep

TC_003 Set Alarm To Remind 
    [Documentation]    To verify task management functionality.Task Management  
    ...     Sets an alarm for a specific task with the given title and time
    ...     Test Steps
    ...     1. Open option remind me
    ...     2. Give a specific time for remind by press date label
    ...     3. Give a specific time for remind by press time label
    ...     Expected Result
    ...     1. Time Label is shown.
    ...     2. Calendar is shown
    ...     3. Clock is shown
    [Tags]  Test Case 3

    Set Alarm For Task




*** Keywords ***
Open App
    Open Application    ${APP_PATH}    platformName=${PLATFORM_NAME}  
    ...      platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}  
    ...      appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}

Verify Open App ToDo

    Wait Until Page Contains Element    //android.widget.TextView[@text="Minimal"]    30 s

Add Task
    [Arguments]    ${task_name}
    Wait Until Element Is Visible        //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB"]     30 s
    Click Element        //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB"]
    Wait Until Element Is Visible        //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/userToDoEditText"]
    Input Text    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/userToDoEditText"]    ${task_name}
    Click Element    //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton"]
    Verify Open App ToDo
    Task Should Be Visible    ${task_name}
    

Edit Task
    [Arguments]    ${old_task_name}    ${new_task_name}
    Long Press Element    xpath=//android.widget.TextView[@text='${old_task_name}']
    Click Element    xpath=//android.widget.EditText[@text='${old_task_name}']
    Clear Element Text    xpath=//android.widget.EditText[@text='${old_task_name}']
    Input Text    xpath=//android.widget.EditText[@text='${old_task_name}']    ${new_task_name}
    Click Element    //android.widget.ImageView[@resource-id="com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton"]
    Verify Open App ToDo
    Task Should Be Visible        ${new_task_name}


Task Should Be Visible
    [Arguments]    ${task_name}
    Element Should Be Visible    xpath=//android.widget.TextView[@text='${task_name}']


Set Alarm For Task
    [Arguments]    ${task_title}    ${alarm_time}
    Long Press Element    xpath=//android.widget.TextView[@text='${old_task_name}']
    wait Until Element Is Visible    xpath=//android.widget.TextView[@text='${task_name}']           30 s
    Click Element   //android.widget.Switch[@resource-id="com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat"]    30 s
    wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Today']           30 s
    Click Element    xpath=//android.widget.TextView[@text='Today'] 
    wait Until Element Is Visible    /hierarchy/android.widget.FrameLayout    30 s
    Click Element    //android.widget.Button[@text='CANCEL']

    wait Until Element Is Visible    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]    30 s
    Click Element    //android.widget.EditText[@resource-id="com.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText"]
    wait Until Element Is Visible    //android.widget.FrameLayout[@content-desc="Hours circular slider: 6"]/android.view.View[4]    30 s
    Click Element    //android.widget.Button[@text='CANCEL']

    Verify Open App ToDo
    Wait Until Element Is Visible    //android.widget.TextView[@text='${task_name}']        30 s
