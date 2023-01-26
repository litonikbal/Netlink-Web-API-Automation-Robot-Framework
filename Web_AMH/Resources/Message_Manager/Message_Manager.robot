*** Settings ***
Library           SeleniumLibrary
Library           String
Library           BuiltIn
Library           Process
Resource          ./Message_Manager_PO.robot

*** Variables ***
${SERVER_MM}            172.31.31.20:8085/swifttools/index.xhtml
${BROWSER}              chrome
${LOGIN_URL_MM}         http://${SERVER_MM}
${TIMEOUT}              30s
${RETRY}                1s
${TITLE_MM}
*** Variables ***

*** Keywords ***
Open Home Page for the Message Manager
    Open Browser    ${LOGIN_URL_MM}    ${BROWSER}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   title should be    SwiftDevSystem

Validate the Home Page for the Message manager
    ${message}    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text   //pre
    should be equal as strings   ${message}   Welcome to Swift tools!!
    ${message}    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Netlink Message Manager

Navigate To MQ For Put Message Page
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //*[contains(text(),'Tools')]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //span[contains(text(),'MQ')]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //span[contains(text(),'Put message')]/parent::a
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //span[contains(text(),'Put message')]/parent::a
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain   Put MQ Message

Select Queue Manager-QM_AMH and Input Queue-SU13.MQ.TOSWIFT.MT
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over          //*[contains(text(),"Queue manager")]/parent::div/div/div[3]/span
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //*[contains(text(),"Queue manager")]/parent::div/div/div[3]/span
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //li[contains(text(),"QM_AMH")]
    sleep   5s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over          //*[contains(text(),"Input queue")]/parent::div/div/label
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //*[contains(text(),"Input queue")]/parent::div/div/label
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //li[contains(text(),"SU13.MQ.TOSWIFT.MT")]
    sleep   5s

Select Message File For Message Put
    ${filePath}   Set Variable   ${CURDIR}\\swift-user13_199_AAA_DDD_DelNot.txt
    log   ${filePath}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over          //*[contains(text(),"Choose")]/preceding-sibling::span/parent::span/parent::span
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //*[contains(text(),"Choose")]/preceding-sibling::span/parent::span/parent::span
    sleep  5s
    ${AutoExeFileLocation}=      set variable  ${CURDIR}\\FileUpload.exe
    ${ProcessID}=  Wait Until Keyword Succeeds  30s    2s     Start Process   ${AutoExeFileLocation}   "${filePath}"
    Wait For Process     on_timeout=Kill
    terminate process      ${ProcessID}     kill=true
    sleep    3s

Send Message To Message Manager Queue
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over          //*[contains(text(),"Put")]/parent::button
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element       //*[contains(text(),"Put")]/parent::button
    sleep   3s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   page should contain     Message successfully put!
    sleep   5s