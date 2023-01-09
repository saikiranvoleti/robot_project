*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${POPUP} =  xpath=//button[text()="✕"]
*** Keywords ***
Load
    Go To  ${URL}

Verify Page Loaded
    Click Element  ${POPUP}
    Wait Until Page Contains  Flipkart
