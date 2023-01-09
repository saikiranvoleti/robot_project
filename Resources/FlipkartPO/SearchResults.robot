*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${SearchResults_Link} =  css=div.col>div

*** Keywords ***
Verify Search Completed
    Wait Until Page Contains  results for "iphone 11"
    Capture Page Screenshot ${OUTPUTDIR}/sel-scrrenshot{index}.png

Click Product Link
    [Documentation]  Clicks on the first product in the search results list
    Click Element  ${searchresults_link}
    Sleep  5s
    Switch Window  locator=NEW
