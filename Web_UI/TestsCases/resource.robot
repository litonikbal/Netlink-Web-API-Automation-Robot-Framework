*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String

*** Variables ***
${SERVER}         192.168.11.18:2443/swp/customgroup/saa
${BROWSER}        chrome
${DELAY}          4
${VALID USER}     robot
${VALID PASSWORD}    Venus2022Venus2022+
${LOGIN URL}      https://${SERVER}/
${WELCOME URL}    https://${SERVER}/
${ERROR URL}      https://${SERVER}/
${SAMPLE TEMP}    ROBOT_TEST_1
${TIMEOUT}        30s
${RETRY}          1s
${TITLE}          Netlink-Mamba SAA Admin 7.6.50
${TemplateName}     ROBOT_TEST-1
*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Login Page Should Be Open
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element    css:div.auth_OL

Login Page Should Be Open
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  Wait Until Page Contains     ${TITLE}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}  Title Should Be    ${TITLE}

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Navigate To Alliance Akura Portal
    Go To    ${LOGIN URL}
    Login Page Should Be Open
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element    //div[contains(text(),"User name and password")]

Input Username
    [Arguments]    ${username}=${VALID USER}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Input Text    gwt-debug-platform_login-username    ${username}

Input Password
    [Arguments]    ${password}=${VALID PASSWORD}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Input Text    gwt-debug-platform_login-password    ${password}

Submit Credentials
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}    Click Button    gwt-debug-platform_login-logon

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Wait Until Page Contains     Netlink-Mamba SAA Admin 7.6.50
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Title Should Be    Netlink-Mamba SAA Admin 7.6.50

Login to the Alliance Akura Portal
    resource.Input Username
    resource.Input Password
    resource.Submit Credentials
    resource.Welcome Page Should Be Open

Click Fin Message Template
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   gwt-debug-desktop-applications-com.swift.Access.samCreationFinTpl

Enter Template Name and Search
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Select Frame  gwt-debug-Alliance_Access_Entry-frame
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Input Text    gwt-debug--messenger-finCreationTemplate-search-criteria-fieldTemplateName    ROBOT_TEST-1
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Button    gwt-debug--messenger-finCreationTemplate-search-criteria-actionSubmit

Click Robot Test Template
    #wait until keyword succeeds  ${TIMEOUT}  ${RETRY}    Select Frame   messenger
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Mouse Over      //*[contains(text(),'${TemplateName}')]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //*[contains(text(),'${TemplateName}')]

Click Body Tab
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}    Select Frame  TMPL_FIN
    run keyword and ignore error    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //*[@id="gwt-debug-dialog-info-0-ok"]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}    Click Element   //div[@id='gwt-debug--messenger-finCreationTemplate-editor-tab-Body']/div/div

Enter Text In Name And Address Body
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}    Click Element    //span[@id='gwt-debug--messenger-finCreationTemplate-editor/1/IMessage/Body/1/Document/MT103/F59a/F59/NameAndAddress/Line']/div/div[6]
    ${ret}=     Generate Random String  12
    Execute javascript
    ...    _editor = document.querySelectorAll("div.CodeMirror")[0].CodeMirror;
    ...    _editor.setValue("A sample automation message ${ret}");

Select Swift Option From Dropdown
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   gwt-debug--messenger-finCreationTemplate-editor-actionDisposeTo
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //td[contains(.,'Swift')]

Logout From The Portal
    unselect frame
    Reload Page
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //div[contains(text(),'Logout')]
    sleep  5s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Button    gwt-debug-dialog-ask-0-ok
    sleep  3s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   title should be   Netlink-Mamba SAA Admin 7.6.50
    ${text}   wait until keyword succeeds   ${TIMEOUT}  ${RETRY}   get text   //div[contains(text(),"Netlink-Mamba SAA Admin 7.6.50")]
    should be equal as strings  Netlink-Mamba SAA Admin 7.6.50   ${text}

Navigate to Message Search Page
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over   //*[@id="gwt-debug-desktop-applications-com.swift.Access.samSearch"]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element   //*[@id="gwt-debug-desktop-applications-com.swift.Access.samSearch"]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   Transaction Reference

Navigate to Akrua Home Page
    Go To    ${LOGIN URL}

Search the Message From AMH With Reference Number
    sleep  30s
    wait until keyword succeeds  5x   30s   Search the Message From AMH With Reference Number In Akura Searches

Search the Message From AMH With Reference Number In Akura Searches
    Navigate to Akrua Home Page
    Navigate to Message Search Page
    select frame    gwt-debug-Alliance_Access_Entry-frame
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over   //*[@id="gwt-debug--messenger-messageSearch-criteria-actionSearch"]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element   //*[@id="gwt-debug--messenger-messageSearch-criteria-actionSearch"]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   ${UniqueRefNumber}    # UniqueRefNumber is variable create at the time of the message sent
    sleep   10s
    select frame    gwt-debug-Alliance_Access_Entry-frame
    ${stts}   get text   //div[contains(text(),"${UniqueRefNumber}")]/parent::td/parent::tr/td[17]/div
    should be equal as strings   ${stts}   Received
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over   //div[contains(text(),"${UniqueRefNumber}")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element   //div[contains(text(),"${UniqueRefNumber}")]    #/parent::td/parent::tr

Validate Message is Received From AMH To Akura
    ${stts}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text   //td[contains(text(),"Transaction Reference")]/following-sibling::td
    should be equal as strings   ${stts}   ${UniqueRefNumber}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over   //div[contains(text(),"Text")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element   //div[contains(text(),"Text")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain    ${UniqueRefNumber}