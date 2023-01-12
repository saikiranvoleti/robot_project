*** Settings ***

Documentation  This is a sample API Test
Library	Collections
Library	RequestsLibrary
Library  Collections
Library  ../Library/CSV_Library.py
Library  ../Library/ReliefCalculator.py
Library    String
Library  OperatingSystem
Library    ../Library/UploadFile.py
Library    CSVLib
Library    JSONLibrary

*** Variables ***
${URL} =  http://localhost:8080
${INSERT_PERSONS} =  /calculator/insert
${INSERT_MULTIPLE_PERSONS} =  /calculator/insertMultiple
${CLACULATE_RELIEF} =  /calculator/taxRelief
${UPLOAD_LARGE_FILE}=   /calculator/uploadLargeFileForInsertionToDatabase
${RAKE_DB}=   /calculator/rakeDatabase
${DISPENSE}=  /calculator/rakeDatabase
${TAX_SUMMARY} =  /calculator/taxReliefSummary

${PERSONS_CSV} =  ${CURDIR}${/}..${/}data/data.csv
${PERSONS_CSV2} =  ${CURDIR}${/}..${/}data/data2.csv
${INVALID_CSV} =  ${CURDIR}${/}..${/}data/invalid_dataset.csv

*** Keywords ***

Insert Working Class Hero
    [Arguments]     ${data}     ${expStatus}
    @{words}=  Split String    ${data}    ,
    ${params}=    Create Dictionary    natid=${words}[0]   name=${words}[1]    gender=${words}[2]   birthday=${words}[3]    salary=${words}[4]     tax=${words}[5]
    Create Session	    session     ${URL}
    ${resp}=  POST On Session   session  ${INSERT_PERSONS}  json=${params}      expected_status=${expStatus}
    Status Should Be  ${expStatus}      ${resp}
    Clear database    200

Insert Multiple Working Class Heros
    [Arguments]     ${csv}  ${expStatus}
    ${file_data}=  Read From Csv File    ${csv}
    ${headers}=     Create Dictionary   Content-Type=application/json     Accept=*/*
    Create Session	    session     ${URL}    debug=3
    ${resp}=  POST On Session  session  ${INSERT_MULTIPLE_PERSONS}   data=${file_data}  headers=${headers}
    Log To Console    ${resp}
    Status Should Be  ${expStatus}    ${resp}


Upload working class hero data using csv file
    [Arguments]     ${csv}      ${expStatus}
    ${resp}=    Post File   ${URL}      ${UPLOAD_LARGE_FILE}     ${csv}
    Log To Console   ${resp}
    Should Be Equal As Strings      ${resp.status_code}         ${expStatus}



Get tax relief for working class heros
     [Arguments]     ${csv}   ${expStatus}
     Create Session  	session     ${URL}
     ${resp}=  GET On Session    session    ${CLACULATE_RELIEF}
     Status Should Be   ${expStatus}    ${resp}
     ${columns}=      Create List     natid   gender   birthday   salary   tax
     ${dict}=  Read Csv As Dictionary    ${csv}   name    ${columns}     ,
     FOR    ${key}   IN    @{dict}
     ${reg} =    Set Variable    $[?(@.name=='${key}')].relief
     ${resp_values}=  Get Value From Json   ${resp.json()}      ${reg}
     ${natid}=  Get Value From Json   ${resp.json()}      $[?(@.name=='${key}')].natid
     #mask validation
     ${bool_mask}=  Verify Mask    ${natid}[0]
     Should Be Equal As Strings    ${bool_mask}     True
     ${values}=  Get From Dictionary    ${dict}    ${key}
     ${exp_tax_relief}=   Calculate Relief    ${values}[1]   ${values}[2]    ${values}[3]     ${values}[4]
     Log To Console    ${key},${natid}[0],${values}[0],${values}[1],${values}[2],${values}[3],${values}[4],${resp_values}[0],${exp_tax_relief}
     Should Be Equal     ${resp_values}[0]  ${exp_tax_relief}
     END

Calculate relief summary
    [Arguments]     ${expStatus}   ${csv}
     Create Session	  session       ${URL}
     ${resp}=   GET On Session    session    ${TAX_SUMMARY}
     Log To Console    ${resp.json()}
     Should Be Equal As Strings       ${resp.status_code}     ${expStatus}
     ${countOfHeros}=  Get Value From Json   ${resp.json()}      $.totalWorkingClassHeroes
     ${totalReliefAmt}=  Get Value From Json   ${resp.json()}      $.totalTaxReliefAmount
     Log To Console    ${countOfHeros}[0]
     Log To Console    ${totalReliefAmt}[0]


Clear Database
     [Arguments]      ${expStatus}
     Create Session	   session      ${URL}
     ${resp}=  POST On Session    session    ${RAKE_DB}
     Should Be Equal As Strings   ${resp.status_code}     ${expStatus}


