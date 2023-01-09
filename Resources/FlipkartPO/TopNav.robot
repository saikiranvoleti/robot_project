*** Settings ***
Documentation  Amazon top navigation
Library  SeleniumLibrary
*** Variables ***

${Top_Nav_Search_Input} =  css=input[type='text'][name='q']
${Top_Nav_Search_Input_Text} =  iphone 11
${Top_Nav_Submit_Btn} =  css=button[type='submit']

*** Keywords ***
Search for Products
    Enter Search Term
    Submit Search

Enter Search Term
    Input Text  ${Top_Nav_Search_Input}  ${top_nav_search_input_text}

Submit Search
    Click Button  ${Top_Nav_Submit_Btn}

