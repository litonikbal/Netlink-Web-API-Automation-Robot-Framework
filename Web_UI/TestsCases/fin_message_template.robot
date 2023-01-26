*** Settings ***
Documentation     A test suite with a Fin Message Template Scenario
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot


*** Test Cases ***
Fin Message Template
    [Tags]   ALLIANCE
    Open Browser To Login Page
    Input Username    ${VALID USER}
    Input Password    ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    Click Fin Message Template
    Enter Template Name and Search
    Click Robot Test Template
    Click Body Tab
    Enter Text In Name And Address Body
    Select Swift Option From Dropdown
    [Teardown]    run keywords      Logout From The Portal   AND
                        ...         Close Browser