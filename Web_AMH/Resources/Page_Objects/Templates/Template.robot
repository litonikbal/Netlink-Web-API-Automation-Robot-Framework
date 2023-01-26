*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
Resource          ./Template_PO.robot

*** Variables ***

*** Keywords ***
Send message By Template
    [Arguments]   ${tempName}=MT199_MANUAL_SU12_FTP_daily
    Navigate to Message Entry From Template
    Select Message template group any Template Name   ${tempName}
    Enter Unique Trans ref in message template
    Create Message

Validate message is Created with Success
    Naviagte to outgoing message search
    Send Refresh Command For Latest Success
    Check Message Details With Compare Transaction Number
    Open Transaction Details and Verify

Validate message is Received with Success
    Naviagte to Incoming message search
    Open Transation Details of the Incoming message
    Validate the Incoming Message

Validate message is Created with Success By Message Manager
    Naviagte to outgoing message search
    Send Refresh Command For Latest Success
    Check Message Details of Message Manager
    Open Transaction Details and Verify

Validate message is Received with Success from Message Manager
    Naviagte to Incoming message search
    Open Transation Details of the Incoming message
    Validate the Incoming Message