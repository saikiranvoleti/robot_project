*** Settings ***
Library  SeleniumLibrary
Library  ScreenCapLibrary
Library    ../Library/CSV_Library.py
*** Variables ***

*** Keywords ***
Begin Web Test
    #Start Video Recording  embed=True
    Open Browser   about:blank    chrome
    Go to  https://www.google.com
    Maximize Browser Window


End Web Test
    Close Browser
    #Stop Video Recording