*** Settings ***
Documentation  This is a sample API Test
Library	Collections
Library	RequestsLibrary
Library  Collections
Library  ../Library/CSV_Library.py
Library  ../Library/ReliefCalculator.py
Library    String
Library  OperatingSystem
Library    JSON

*** Variables ***
${URL} =  http://localhost:8080
${INSERT_PERSONS} =  /calculator/insert
${INSERT_MULTIPLE_PERSONS} =  /calculator/insertMultiple
${CLACULATE_RELIEF} =  /calculator/taxRelief
${UPLOAD_LARGE_FILE}=   /calculator/uploadLargeFileForInsertionToDatabase
${PERSONS_CSV} =  ${CURDIR}${/}data.csv
${PERSONS_CSV2} =  ${CURDIR}${/}data2.csv
*** Test Cases ***

#US01_As the Clerk, I should be able to insert a single record of working class hero into database via an API
#    [Documentation]  AC1: Single record of a working class hero should consist of Natural Id (natid), Name, Gender, Birthday, Salary and Tax paid.   /calculator/insert
#    [Template]    Insert Working Class Hero
#    110004,kajal,f,08072005,15000,10000  202
#    110005,sai,m,invaliddob,10000,1000  500
#
#US02_As the Clerk, I should be able to insert more than one working class hero into database via an API
#     [Documentation]    AC1: Enhancement of (1), with the ability to insert a list.  /calculator/insertMultiple
#    Insert Multiple Working Class Heros    ${PERSONS_CSV}   202

#US03_As the Clerk, I should be able to upload a csv file to a portal so that I can populate the database from a UI
#    [Documentation]  AC1: First row of the csv file must be natid, name, gender, salary, birthday, tax
#    [Documentation]  AC2: Subsequent rows of csv are the relevant details of each working class hero
#    [Documentation]  AC3: A simple button that allows me to upload a file on my pc to the portal /calculator/uploadLargeFileForInsertionToDatabase
#   Upload working class hero data using csv file      ${PERSONS_CSV}  200

US04_As the Bookkeeper, I should be able to query the amount of tax relief for each person in the database so that I can report the figures to my Bookkeeping Manager
     [Documentation]  AC1: a GET endpoint which returns a list consist of natid, tax relief amount and name
     [Documentation]  AC2: natid field must be masked from the 5th character onwards with dollar sign ‘$’
     [Documentation]  AC4: After calculating the tax relief amount, it should be subjected to normal rounding rule to remove any decimal places
    [Documentation]  AC5: If the calculated tax relief amount after subjecting to normal rounding rule is more than 0.00 but less than 50.00, the final tax relief amount should be 50.00
    [Documentation]  AC6: If the calculated tax relief amount before applying the normal rounding rule gives a value with more than 2 decimal places, it should be truncated at the second decimal place and then subjected to normal rounding rule
    [Documentation]  AC3: computation of the tax relief is using the formula as described:
    Get tax relief for working class heros     ${PERSONS_CSV2}




*** Keywords ***
Insert Working Class Hero
    [Arguments]     ${data}     ${expStatus}    ${error}=
    @{words}=  Split String    ${data}  ,
    ${params}=    Create Dictionary    natid=${words}[0]   name=${words}[1]    gender=${words}[2]   birthday=${words}[3]    salary=${words}[4]     tax=${words}[5]
    Create Session	session  ${URL}
    ${resp}=  POST On Session   session  ${INSERT_PERSONS}  json=${params}      expected_status=${expStatus}
    Status Should Be  ${expStatus}      ${resp}

Insert Multiple Working Class Heros
    [Arguments]     ${csv}  ${expStatus}
    ${file_data}=  Read From Csv File    Csv File        ${csv}
    ${headers}=     Create Dictionary   Content-Type=application/json     Accept=*/*
    Create Session	session  ${URL}    debug=3
    ${resp}=  POST On Session  session  ${INSERT_MULTIPLE_PERSONS}   data=${file_data}  headers=${headers}
    Log To Console    ${resp}
    Status Should Be  ${expStatus}    ${resp}

Upload working class hero data using csv file
    [Arguments]     ${csv}  ${expStatus}
    ${headers}=     Create Dictionary   Content-Type=multipart/form-data     Accept=*/*
    ${file_data}=  Read From Csv File    Csv File   ${csv}
    ${files}=   Create Dictionary  file=${file_data}
    Create Session	session  ${URL}    debug=3
    ${resp}=  POST On Session   session  ${UPLOAD_LARGE_FILE}   data=${files}  headers=${headers}
    Log To Console    ${resp}
    Status Should Be  ${expStatus}    ${resp}

Get tax relief for working class heros











