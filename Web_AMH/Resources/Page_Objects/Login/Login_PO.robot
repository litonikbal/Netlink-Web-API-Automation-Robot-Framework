*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
*** Keywords ***
Input Username
    [Arguments]    ${username}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Input Text    login-user-field    ${username}

Input Password
    [Arguments]    ${password}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Input Text    login-password-field    ${password}

Submit Credentials to AMH
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     login-signon
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   File
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   System
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   New Message
    Run Keyword And Ignore Error   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       infoDialog-ok

Click to File Option
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //button[contains(text(),"File")]

Click to Exit Option
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //td[contains(text(),"Exit")]
