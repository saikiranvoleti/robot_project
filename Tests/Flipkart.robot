*** Settings ***

Documentation  this is a sample suite
Resource  ../Resources/Common.robot
Resource  ../Resources/FlipkartApp.robot
Test Setup  Begin Web Test
Test Teardown  End Web Test
*** Variables ***
${URL} =  https://www.flipkart.com/
${OUTPUTDIR} =  ./Results/
*** Test Cases ***
Logged out user can search for products
    [Tags]  Web
    Given user is not logged in
    When user searches for products
    Then search results contains relevant products

Logged out user can view a product
    [Tags]  Web
    Given user is not logged in
    When user selects a searched product
    Then correct product page loads

Logged out user can add product to cart
    [Tags]  Web
    Given user is not logged in
    And user selects a searched product
    When user adds that product to their cart
    Then the product is present in cart

Logged out user must sign in to check out
    [Tags]  Web  Smoke
    Given user is not logged in
    And user adds a product to their cart
    When user attempts to checkout
    Then the user is required to sign in
