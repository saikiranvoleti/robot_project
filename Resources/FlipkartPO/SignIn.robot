*** Settings ***
Library  SeleniumLibrary

*** Variables ***

${SignIn_Nav} =  xpath=//h3/span[text()='Login or Signup']
${SignIn_Nav_Text} =  Login

*** Keywords ***
Verify Page Loaded
    Page Should Contain Element  ${SignIn_Nav}
    Capture Page Screenshot ${OUTPUTDIR}/sel-scrrenshot{index}.png
