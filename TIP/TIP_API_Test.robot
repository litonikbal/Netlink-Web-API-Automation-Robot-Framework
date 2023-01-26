*** Settings ***
Documentation    This file is for the TIP Test

Library     RequestsLibrary
Library     SeleniumLibrary
Library     SSHLibrary
Resource    ./TIP_Resource.robot
*** Test Cases ***
TC01: TIP API Test with URL
    [Tags]    TIP   API
    create session   tipsession   ${TIP_URL}
    ${resp}   get on session    tipsession   /SwiftHandler
    log  Status Code from the URL [${TIP_URL}/SwiftHandler] GET by API is ${resp.status_code}   console=true
    log  Status of the Service : ${resp.content}   console=true
    should be equal as strings   200   ${resp.status_code}
    should be equal as strings   SwiftHandler running Successfully   ${resp.content}
    [Teardown]   Delete All Sessions

TC02: TIP URL Browser Test
    [Tags]    TIP   UI
    open browser   ${TIP_URL}/SwiftHandler     ${BROWSER}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    ${text}   wait until keyword succeeds  10s  1s   page should contain   SwiftHandler running Successfully
    sleep  2s
    [Teardown]  close all browsers

TC03: TIP SSH Login And Services Status
    [Tags]    TIP   SSH
    Open Connection	  ${TIP_IP}
    ${output}=	Login	netlink  adsl55
    Should Contain	${output}	Last login:
    ${curlResp}=	 Execute Command	  curl http://localhost:8080/SwiftHandler    sudo=True   sudo_password=adsl55
    log  ************* curl http://localhost:8080/SwiftHandler Command Response *******************\n   console=true
    log  ${curlResp}   console=true
    log  ************* End Of Response *******************   console=true
    should be equal as strings   ${curlResp}      SwiftHandler running Successfully

    #${sudoSU}=	 Execute Command	  su    sudo=True   sudo_password=adsl55
    #log   ${sudoSU}
    ${statusTransLation}=	 Execute Command	  systemctl status Translation    sudo=True   sudo_password=adsl55
    log  ************* systemctl status Translation Command Response *******************      console=true
    log  ${statusTransLation}   console=true
    log  ************* End Of Response *******************    console=true

    should contain   ${statusTransLation}   Translation.service - Translation service run
    should contain   ${statusTransLation}   (code=exited, status=0/SUCCESS)
    [Teardown]  Close Connection