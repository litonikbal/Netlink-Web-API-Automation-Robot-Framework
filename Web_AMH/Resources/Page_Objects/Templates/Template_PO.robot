*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
*** Keywords ***
Navigate to Message Entry From Template
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element     //button[contains(text(),"System")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element     //*[contains(text(),"Message Entry From Template")]

Select Message template group any Template Name
    [Arguments]   ${tempName}=MT199_MANUAL_SU12_FTP_daily
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //*[contains(text(),"MT1XX ${SPACE}(Customer Payments and Cheques)")]/preceding-sibling::td
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Click Element     //*[contains(text(),"MT1XX ${SPACE}(Customer Payments and Cheques)")]/preceding-sibling::td
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   double click element     //*[contains(text(),"${tempName}")]
    sleep   3s

Enter Unique Trans ref in message template
    ${refNum}    generate random string   8   [NUMBERS]
    ${UniqueRefNumber}    set variable   ROBOT${refNum}
    set test variable   ${UniqueRefNumber}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //*[contains(text()," Transaction Reference Number:")]/parent::td/following-sibling::td/input
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   clear element text     //*[contains(text()," Transaction Reference Number:")]/parent::td/following-sibling::td/input
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   input text     //*[contains(text()," Transaction Reference Number:")]/parent::td/following-sibling::td/input    ${UniqueRefNumber}

Create Message
    sleep  1s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //*[contains(text(),"Create Message")]
    sleep  2s

Naviagte to outgoing message search
    @{listOfDropDowns}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Get WebElements   //*[contains(text(),"Public Searches")]/parent::td/parent::tr/td[2]/div
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     ${listOfDropDowns[0]}
    sleep  1s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     ${listOfDropDowns[0]}
    sleep  2s
    @{listOfElements}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Get WebElements   //span[contains(text(),"Last 2 Hours")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     ${listOfElements[0]}
    sleep  1s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     ${listOfElements[0]}
    sleep  5s

Send Refresh Command For Latest Success
    FOR  ${i}  IN RANGE  1   10
     wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //button[@title="Refresh"]
     sleep  2s
     wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //button[@title="Refresh"]
     sleep  3s
     ${stts1}  run keyword and return status   page should contain   ${UniqueRefNumber}
     ${text}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[4]
     ${stts2}  run keyword and return status   should be equal as strings   ${text}   Sent
     ${stts}   set variable if   ${stts1}    ${stts2}   ${FALSE}
     Exit For Loop If   ${stts}
    END

Check Message Details With Compare Transaction Number
    ${text}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[4]
    should be equal as strings   ${text}   Sent
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[5]
    should be equal as strings   ${text}   OK
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[6]
    should be equal as strings   ${text}   Ack Received
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[10]
    should be equal as strings   ${text}   ${UniqueRefNumber}
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[13]
    should be equal as strings   ${text}   ACK

Check Message Details of Message Manager
    ${text}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[4]
    should be equal as strings   ${text}   Sent
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[5]
    should be equal as strings   ${text}   Positive Delivery Notification
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[10]
    should be equal as strings   ${text}   ${UniqueRefNumber}
    ${text}   get text   //*[@id="InventoryPanel"]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/table/tbody/tr[2]/td[13]
    should be equal as strings   ${text}   ACK

Open Transaction Details and Verify
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   double click element     //td[contains(text(),"${UniqueRefNumber}")]/parent::tr
    sleep  3s
    ${checkedRefNum}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text     //*[contains(text(),"Transaction Reference Number")]/parent::td/following-sibling::td[2]/pre
    should be equal as strings    ${UniqueRefNumber}    ${checkedRefNum}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //button[contains(text(),"Close")]
    sleep  3s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //button[contains(text(),"Close")]
    sleep  2s

Naviagte to Incoming message search
    @{listOfDropDowns}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Get WebElements   //*[contains(text(),"Public Searches")]/parent::td/parent::tr/td[2]/div
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     ${listOfDropDowns[1]}
    sleep  1s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     ${listOfDropDowns[1]}
    sleep  2s
    @{listOfElements}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   Get WebElements   //span[contains(text(),"Last 2 Hours")]
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     ${listOfElements[2]}
    sleep  2s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     ${listOfElements[2]}
    sleep  5s

Open Transation Details of the Incoming message
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   double click element     //td[contains(text(),"${UniqueRefNumber}")]/parent::tr
    sleep  3s

Validate the Incoming Message
    ${checkedRefNum}   wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   get text     //*[contains(text(),"Transaction Reference Number")]/parent::td/following-sibling::td[2]/pre
    should be equal as strings    ${UniqueRefNumber}    ${checkedRefNum}
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   mouse over     //button[contains(text(),"Close")]
    sleep  3s
    wait until keyword succeeds  ${TIMEOUT}  ${RETRY}   click element     //button[contains(text(),"Close")]
    sleep  2s

