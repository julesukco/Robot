*** Settings ***
Library    Browser
Library    OperatingSystem
Library    BuiltIn  # Import BuiltIn library for checking test status
Library    CustomLibrary  # Assuming your custom library
Library    TestStatusListener.py
Test Teardown    End Test

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    false

*** Test Cases ***
104848515 Create Quote for Car
    Open Insurance Application
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data

*** Keywords ***
Open Insurance Application
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-GB
    New Page    http://sampleapp.tricentis.com/

Enter Vehicle Data for Automobile
    Click    div.main-navigation >> "Automobile"
    Select Options By    id=make    text    Audi
    Fill Text    id=engineperformance    110
    Fill Text    id=dateofmanufacture    06/12/1980
    Select Options By    id=numberofseats    text    5
    Select Options By    id=fuel    text    Petrol    
    Fill Text    id=listprice    30000
    Fill Text    id=licenseplatenumber    DMK1234
    Fill Text    id=annualmileage   10000 
    Click    section[style="display: block;"] >> text=Next »

Enter Insurant Data
    [Arguments]    ${firstname}=Max    ${lastname}=Mustermann
    Fill Text    id=firstname    Max
    Fill Text    id=lastname    Mustermann
    Fill Text    id=birthdate    01/31/1980
    Check Checkbox    *css=label >> id=gendermale
    Fill Text    id=streetaddress    Test Street
    Select Options By    id=country    text    Germany
    Fill Text    id=zipcode    40123
    Fill Text    id=city    Essen
    Select Options By    id=occupation    text    Employee
    Click    text=Cliff Diving
    Click    section[style="display: block;"] >> text=Next »

Enter Product Data
    Fill Text    id=startdate    06/01/2023
    Select Options By    id=insurancesum    text    7.000.000,00
    Select Options By    id=meritrating    text    Bonus 1
    Select Options By    id=damageinsurance    text    No Coverage
    Check Checkbox    *css=label >> id=EuroProtection
    Select Options By    id=courtesycar    text    Yes

# Check Specific Step Status
#     # Check if entering vehicle data was successful
#     ${status_passed}    Run Keyword And Return Status    Enter Vehicle Data for Automobile
#     Log    Vehicle data entry passed: ${status_passed}

# End Test and Log Final Status
#     # Capture the overall test case status
#     ${final_status}    Set Variable If    '${TEST_STATUS}' == 'PASS'    PASS    FAIL

#     # Optionally, use your custom library to record the test status

End Test
    Capture Test Case Status    ${TEST_NAME}    ${TEST_STATUS}    ${TEST_MESSAGE}
    Close Browser
    Close Context

