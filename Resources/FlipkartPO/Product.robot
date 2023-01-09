*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${Product_AddToCart_Btn} =  xpath=//button[text()='ADD TO CART']

*** Keywords ***
Verify Page Loaded
    Wait Until Page Contains  Compare
    Capture Page Screenshot ${OUTPUTDIR}/formatted_{index}.png

Add to Cart
    Click Button  ${product_addtocart_btn}