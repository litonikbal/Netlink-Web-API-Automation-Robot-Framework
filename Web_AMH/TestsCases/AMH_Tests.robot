*** Settings ***
Documentation       Test Case for the AMH and Message Manager Integration
...  \n             Test Case 1 : AMH Login and Logout With Valid User
...  \n             Test Case 2 : AMH Sending Message to AMH Manual FLow
...  \n             Test Case 3 : AMH Sending Message to SAA Akura Manual FLow

Resource          ../Resources/Page_Objects/Login/Login.robot
Resource          ../Resources/Page_Objects/Templates/Template.robot
Resource          ../../Web_UI/TestsCases/resource.robot
*** Variables ***
${TEMPLATE_NAME}    MT_199_AMH_TO_SAA_AKURA_SU3_JJJ

*** Test Cases ***
TC001-AMH1_Login_And_Logout
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to AMH Web Portal url : ${LOGIN_URL_AMH}
    ...   \n Step 2    Validate the Home page is opened Properly with Dashboard Content.
    ...   \n Step 3    Logout from the AMH web protal and close all browsers.
    [Tags]      AMH
    Login.Open Browser To Login Page
    Login to the AMH Web Application
    Logout from the AMH Web Application
    sleep   5s
    [Teardown]    run keywords      Close Browser

AMH1_Sending Message_To_AMH1_Manual_Flow
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to AMH Web Portal url : ${LOGIN_URL_AMH}
    ...   \n Step 2    Validate the Home page is opened Properly with Dashboard Content.
    ...   \n Step 3    Send a Message from AMH Portal using a Saved Template
    ...   \n Step 4    Validate Message is created with Success
    ...   \n Step 5    Validate Message is received with Success
    ...   \n Step 6    Logout from the AMH web protal and close all browsers.
    [Tags]      AMH    TEMPLATE
    Login.Open Browser To Login Page
    Login to the AMH Web Application
    Send message By Template
    Validate message is Created with Success
    Validate message is Received with Success
    Logout from the AMH Web Application
    sleep   3s
    [Teardown]    run keywords      Close Browser

AMH1_To_SAA_Akura_Manual_Flow
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to AMH Web Portal url : ${LOGIN_URL_AMH}
    ...   \n Step 2    Validate the Home page is opened Properly with Dashboard Content.
    ...   \n Step 3    Send a Message from AMH Portal using a Saved Template
    ...   \n Step 4    Validate Message is created with Success
    ...   \n Step 5    Validate Message is received with Success
    ...   \n Step 6    Logout from the AMH web protal and close all browsers.
    ...   \n Step 7    Login to Akura SAA portal
    ...   \n Step 8    Search the Message From AMH With Reference Number in Recent messages
    ...   \n Step 9    Search the Message From AMH With Reference Number in Recent messages
    ...   \n Step 10   Logout from the Akura SAA web protal and close all browsers.
    [Tags]      AMH    TEMPLATE   ALLIANCE
    Login.Open Browser To Login Page
    Login to the AMH Web Application
    Send message By Template    ${TEMPLATE_NAME}
    Validate message is Created with Success
    Logout from the AMH Web Application
    Navigate To Alliance Akura Portal
    Login to the Alliance Akura Portal
    Search the Message From AMH With Reference Number
    Validate Message is Received From AMH To Akura
    Logout From The Portal
    sleep   3s
    [Teardown]    run keywords      Close Browser