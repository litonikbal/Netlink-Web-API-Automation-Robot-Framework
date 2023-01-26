*** Settings ***
Documentation       Test Case for the AMH and Message Manager Integration
...  \n             Test Case 1 : Security Officer Login At Akura Portal
...  \n             Test Case 2 : Security Officer Login At Torch Portal
...  \n             Test Case 3 : Security Officer Login At Viper Portal

Resource          ../Resources/Page_Objects/Login/Login.robot
Resource          resource.robot
Test Teardown     Close Browser
*** Variables ***
${SAA_URL}    https://172.31.31.168:2443/swp/customgroup/saa/#
${AKURA_SO_USER}    LSO
${TORCH_SO_USER}    LSO
${VIPER_SO_USER}    LSO
${AKURA_SO_PWD}    Maru2022Maru2022$
${TORCH_SO_PWD}    Venus2009Venus2009+
${VIPER_SO_PWD}    Venus2009Venus2009+
*** Test Cases ***
Security Officer Login At Akura Portal
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to Message Manager Web Portal url : ${SAA_URL}
    ...   \n Step 2    Enter User name and Password
    ...   \n Step 3    Select the Server instance to Akura
    ...   \n Step 4    Submit Credentials
    ...   \n Step 5    Validate the Login Success
    ...   \n Step 6    Logout from SAA portal
    [Tags]   SOLogin  Akura
    Navigate to SAA Home Page
    Select saa76_akura from Alliance Server Instance
    Input Username  ${AKURA_SO_USER}
    Input Password  ${AKURA_SO_PWD}
    Submit Credentials
    Validate That SO Login is Success for saa76_akura
    Logout From The SAA Admin Portal

Security Officer Login At Torch Portal
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to Message Manager Web Portal url : ${SAA_URL}
    ...   \n Step 2    Enter User name and Password
    ...   \n Step 3    Select the Server instance to Torch
    ...   \n Step 4    Submit Credentials
    ...   \n Step 5    Validate the Login Success
    ...   \n Step 6    Logout from SAA portal
    [Tags]   SOLogin  Torch
    Navigate to SAA Home Page
    Select saa76_torch from Alliance Server Instance
    Input Username  ${TORCH_SO_USER}
    Input Password  ${TORCH_SO_PWD}
    Submit Credentials
    Validate That SO Login is Success for saa76_torch
    Logout From The SAA Admin Portal

Security Officer Login At Viper Portal
    [Documentation]     Test Case Steps :
    ...   \n Step 1    Open the Browser and Navigate to Message Manager Web Portal url : ${SAA_URL}
    ...   \n Step 2    Enter User name and Password
    ...   \n Step 3    Select the Server instance to Viper
    ...   \n Step 4    Submit Credentials
    ...   \n Step 5    Validate the Login Success
    ...   \n Step 6    Logout from SAA portal
    [Tags]   SOLogin   Viper
    Navigate to SAA Home Page
    Select saa76_viper from Alliance Server Instance
    Input Username  ${VIPER_SO_USER}
    Input Password  ${VIPER_SO_PWD}
    Submit Credentials
    Validate That SO Login is Success for saa76_viper
    Logout From The SAA Admin Portal

*** Keywords ***
Navigate to SAA Home Page
    Open Browser    ${SAA_URL}    ${BROWSER}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  Wait Until Page Contains   Netlink-Cobra SAA Admin
    ${titleText}    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  get title
    should contain  ${titleText}   Netlink-Cobra SAA Admin
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element    css:div.auth_OL

Select ${Type} from Alliance Server Instance
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element    //*[@id="gwt-debug-platform_login-instances"]/input
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element    //div[contains(text(),"${Type}")]

Validate That SO Login is Success for ${type}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Alliance Server Instance: ${type}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     User: LSO
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Netlink-Cobra SAA Admin
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Backup Config
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Monitoring
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Event Log
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Application Config
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Message Handler
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     User Administration

Logout From The SAA Admin Portal
    unselect frame
    Reload Page
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //div[contains(text(),'Logout')]
    sleep  5s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Button    gwt-debug-dialog-ask-0-ok
    sleep  3s
    ${text}   wait until keyword succeeds   ${TIMEOUT}  ${RETRY}   get text   //div[contains(text(),"Netlink-Cobra SAA Admin")]
    should contain  ${text}   Netlink-Cobra SAA Admin