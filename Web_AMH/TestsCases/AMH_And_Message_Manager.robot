*** Settings ***
Documentation       Test Case for the AMH and Message Manager Integration
...  \n             Test Case 1 : Message_Manager_Application_Home_Page
...  \n             Test Case 2 : Message_Manager_To_AMH_Manual_Flow
Resource          ../Resources/Page_Objects/Login/Login.robot
Resource          ../Resources/Message_Manager/Message_Manager.robot
Resource          ../Resources/Message_Manager/Message_Manager_PO.robot
Resource          ../Resources/Page_Objects/Templates/Template.robot
*** Variables ***


*** Test Cases ***
TC001-Message_Manager_Application_Home_Page
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to Message Manager Web Portal url : ${LOGIN_URL_MM}
    ...   \n Step 2    Validate the Home page is opened Properly with Dashboard Content
    ...   \n Step 3    Navigate to the Put Message option and Check if Put Message is allowed.
    [Tags]      MM    AMH
    Open Home Page for the Message Manager
    Validate the Home Page for the Message manager
    Navigate To MQ For Put Message Page
    [Teardown]    run keywords   close all browsers

TC002-Message_Manager_To_AMH_Manual_Flow
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to Message Manager Web Portal url : ${LOGIN_URL_MM}
    ...   \n Step 2    Validate the Home page is opened Properly with Dashboard Content.
    ...   \n Step 3    Navigate to the Put Message option and Check if Put Message is allowed.
    ...   \n Step 4    Select Queue Manager QM_AMH and Input Queue SU13.MQ.TOSWIFT.MT and Select Text file with message then Send message.
    ...   \n Step 5    Login to AMH Web Portal in New browser and Validate AMH Dashboard is loaded successfully
    ...   \n Step 6    Navigate to the Incoming Message and Validate that Message in Present in the Incoming Messages
    ...   \n Step 7    Navigate to the Outgoing Message and Validate that Message in Present in the Outgoing Messages
    ...   \n Step 6    Logout from the AMH web protal and close all browsers.
    [Tags]      MM    AMH
    Open Home Page for the Message Manager
    Validate the Home Page for the Message manager
    Navigate To MQ For Put Message Page
    Select Queue Manager-QM_AMH and Input Queue-SU13.MQ.TOSWIFT.MT
    Select Message File For Message Put
    Send Message To Message Manager Queue
    Login.Open Browser To Login Page
    Login to the AMH Web Application
    set test variable   ${UniqueRefNumber}   ROBOTSTPFLOW
    Validate message is Created with Success By Message Manager
    Validate message is Received with Success From Message Manager
    Logout from the AMH Web Application
    sleep   3s
    [Teardown]    run keywords   close all browsers