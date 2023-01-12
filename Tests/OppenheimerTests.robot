*** Settings ***
Resource    ../Resources/OppenheimerCommon.robot
*** Variables ***

${PERSONS_CSV} =  ${CURDIR}${/}..${/}data/data.csv
${PERSONS_CSV2} =  ${CURDIR}${/}..${/}data/data2.csv
${INVALID_CSV} =  ${CURDIR}${/}..${/}data/invalid_dataset.csv

*** Test Cases ***

US01_As the Clerk, I should be able to insert a single record of working class hero into database via an API
    [Tags]  API
    [Documentation]  AC1: Single record of a working class hero should consist of Natural Id (natid), Name, Gender, Birthday, Salary and Tax paid.   /calculator/insert
    [Template]    Insert Working Class Hero
    110001,Aidan Frazier,m,04031979,4491,136  202
    110002,Marsden Sosa,m,invaliddob,1395,407   500
    110002,Marsden Sosa,m,0403197901010101010,1395,407   500


US02_As the Clerk, I should be able to insert more than one working class hero into database via an API
     [Tags]  API
     [Documentation]    AC1: Enhancement of (1), with the ability to insert a list.  /calculator/insertMultiple
     Clear database    200
     Insert Multiple Working Class Heros    ${PERSONS_CSV}   202
     Clear database    200


US03_As the Clerk, I should be able to upload a csv file to a portal so that I can populate the database from a UI
    [Tags]  API
    [Documentation]  AC1: First row of the csv file must be natid, name, gender, salary, birthday, tax
    [Documentation]  AC2: Subsequent rows of csv are the relevant details of each working class hero
    [Documentation]  AC3: A simple button that allows me to upload a file on my pc to the portal /calculator/uploadLargeFileForInsertionToDatabase
    Clear database    200
    #valid dataset upload
   Upload working class hero data using csv file    ${PERSONS_CSV2}    200
#    #invalid dataset upload
    Upload working class hero data using csv file    ${INVALID_CSV}   500
    Clear Database     200


US04_As the Bookkeeper, I should be able to query the amount of tax relief for each person in the database so that I can report the figures to my Bookkeeping Manager
     [Tags]  API
     [Documentation]  AC1: a GET endpoint which returns a list consist of natid, tax relief amount and name  /calculator/taxRelief  & /calculator/taxReliefSummary
     [Documentation]  AC2: natid field must be masked from the 5th character onwards with dollar sign ‘$’
     [Documentation]  AC4: After calculating the tax relief amount, it should be subjected to normal rounding rule to remove any decimal places
    [Documentation]  AC5: If the calculated tax relief amount after subjecting to normal rounding rule is more than 0.00 but less than 50.00, the final tax relief amount should be 50.00
    [Documentation]  AC6: If the calculated tax relief amount before applying the normal rounding rule gives a value with more than 2 decimal places, it should be truncated at the second decimal place and then subjected to normal rounding rule
    [Documentation]  AC3: computation of the tax relief is using the formula as described:
    Upload working class hero data using csv file    ${PERSONS_CSV2}    200
    Get tax relief for working class heros     ${PERSONS_CSV2}      200
    Calculate relief summary   200   ${PERSONS_CSV2}
    Clear Database    200






