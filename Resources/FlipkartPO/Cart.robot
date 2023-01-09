*** Settings ***
Library  SeleniumLibrary
Library  Dialogs
*** Variables ***
${Cart_Checkout_Btn} =  xpath=//span[text()='Place Order']
*** Keywords ***
Verify Product Added
    Wait Until Page Contains  Place Order
    Capture Page Screenshot ${OUTPUTDIR}/sel-scrrenshot{index}.png

Proceed to Checkout
    Click Element  ${cart_checkout_btn}