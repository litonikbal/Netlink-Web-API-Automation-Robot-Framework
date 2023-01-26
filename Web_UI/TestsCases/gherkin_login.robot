*** Settings ***
Documentation     A test suite with a single Gherkin style test.
...
...               This test is functionally identical to the example in
...               valid_login.robot file.
Resource          resource.robot
Test Teardown     Close Browser

*** Test Cases ***
Valid Login
    [Documentation]
    [Tags]   Login
    Given browser is opened to login page
    When user ${VALID USER} logs in with password ${VALID PASSWORD}
    Then welcome page should be open
    And User Logs out from Alliance portal
*** Keywords ***
Browser is opened to login page
    Open browser to login page

User ${username} logs in with password ${password}
    Input username    ${username}
    Input password    ${password}
    Submit credentials

User Logs out from Alliance portal
    log   Doing logout action
    sleep   10s
    Logout From The Portal