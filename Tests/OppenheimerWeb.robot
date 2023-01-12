*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/Common.robot
Resource   ../Resources/OppenheimerCommon.robot

Documentation  (5) As the Governor, I should be able to see a button on the screen so
Documentation  that I can dispense tax relief for my working class heroes
Documentation  AC1: The button on the screen must be red-colored
Documentation  AC2: The text on the button must be exactly “Dispense Now”
Documentation  AC3: After clicking on the button, it should direct me to a page with a  text that says “Cash dispensed”


Test Setup  Begin Web Test
Test Teardown  End Web Test

*** Variables ***
${URL} =  http://localhost:8080/
${OUTPUTDIR} =  ./Results/
${DISPENSE_BUTTON} =  css=a[href='dispense'][class*='btn-danger']
${CASH_DISPENSE_LBL} =  css=div.display-4
${RED_RGB} =  rgba(220, 53, 69, 1)
${DISPENSE_TXT} =   Dispense Now
${DISPENSED_TXT} =   Cash dispensed
${FILE_INPUT} =  css=input.custom-file-input
${REFRESH_RELIEF_BTN} =  css=button.btn.btn-primary
${RELIEF_TABLE} =  css=table.table-hover
${PERSONS_CSV2} =   ${CURDIR}${/}..${/}data/data2.csv
${TABLE_RELIEF}=    css=table.table-hover tr>td:nth-of-type(2)
${RELIEF_TEXT}=  css=div.jumbotron p
*** Test Cases ***

US005_Oppenheimer Web test
    [Tags]  Web
    Clear database   200
    Go To  ${URL}
    Wait Until Element Is Visible    ${DISPENSE_BUTTON}
    Element Should Be Visible    ${DISPENSE_BUTTON}
    ${element}=  Get Webelement     ${DISPENSE_BUTTON}
    ${color}=  Call Method    ${element}    value_of_css_property     background-color
    #validate despense color
    Should Be Equal As Strings    ${RED_RGB}     ${color}
    #The text on the button must be exactly “Dispense Now”
    ${text}=  Get Text      ${DISPENSE_BUTTON}
    Should Be Equal As Strings    ${text}     ${DISPENSE_TXT}
    #Cash dispensed validation
    Click Element     ${DISPENSE_BUTTON}
    Wait Until Element Is Visible    ${CASH_DISPENSE_LBL}
    ${text}=  Get Text      ${CASH_DISPENSE_LBL}
    Should Be Equal As Strings    ${text}     ${DISPENSED_TXT}


US005_Oppenheimer Web Upload File Test
    [Tags]  Web
    Clear database   200
    Go To  ${URL}
    Wait Until Element Is Visible    ${DISPENSE_BUTTON}
    ${csvpath}=  Normalize Path    ${PERSONS_CSV2}
    Input Text    ${FILE_INPUT}       ${csvpath}
    Click Element    ${REFRESH_RELIEF_BTN}
    Element Should Be Visible    ${RELIEF_TABLE}
    #from UI
    ${ele_count}=  Get Element Count    ${TABLE_RELIEF}
    #from csv
    ${csv_count}=  Get Column Count    ${PERSONS_CSV2}    salary
    #no of hers validation
    Should Be Equal As Strings    ${ele_count}     ${csv_count}
    Log To Console    ${ele_count},${csv_count}







