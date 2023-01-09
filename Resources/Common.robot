*** Settings ***
Library  SeleniumLibrary
Library  ScreenCapLibrary
*** Variables ***

*** Keywords ***
Begin Web Test
    #Start Video Recording  embed=True
    Open Browser  about:blank  chrome
    Maximize Browser Window


End Web Test
    Close Browser
    #Stop Video Recording