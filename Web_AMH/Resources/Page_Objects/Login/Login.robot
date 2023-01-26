*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
Resource          Login_PO.robot

*** Variables ***
${SERVER_AMH}           172.31.31.147:8443/amhweb/
${BROWSER}              chrome
${VALID_USER_AMH}       robot
${VALID_PASSWORD_AMH}   Password1!
${LOGIN_URL_AMH}        https://${SERVER_AMH}
${TIMEOUT}              60s
${RETRY}                1s
${TITLE_AMH}            AMH - ${VALID_USER_AMH} - PN1
*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL_AMH}    ${BROWSER}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Login Page Should Be Open AMH

Login Page Should Be Open AMH
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  Wait Until Page Contains     AMH
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  Title Should Be    AMH
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Page should contain    Alliance Messaging Hub - LDAP Login
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Page should contain    Welcome to AMH
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Page should contain    Password:
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Page should contain    User:

Go To Login Page
    Go To    ${LOGIN_URL_AMH}
    Login Page Should Be Open AMH

Login to the AMH Web Application
    [Documentation]    This keyword is for logging into the AMH portal
    Login_PO.Input Username    ${VALID_USER_AMH}
    Login_PO.Input Password    ${VALID_PASSWORD_AMH}
    Submit Credentials to AMH

Logout from the AMH Web Application
    Click to File Option
    Click to Exit Option
    Login Page Should Be Open AMH


