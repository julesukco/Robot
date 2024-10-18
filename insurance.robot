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
104848515 Shop iPhone
    Open Home Page
    Choose iPhone Shop Now
    Choose iPhone Model
    Add Phone to Cart

*** Keywords ***
Open Home Page
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-US
    New Page    https://boostmobile.com

Choose iPhone Shop Now
    Click    xpath=(//a[span[contains(text(), 'Shop Now')]])[2]

Choose iPhone Model
    Click    xpath=(//span[@class="cmp-button__text" and contains(text(), 'Select')])[2]
Add Phone to Cart
    Click    xpath=(//span[contains(text(), 'Decline Protection')])
    Click    xpath=(//label[contains(text(), 'New Number')])
    Click    xpath=(//span[contains(text(), 'Pay Today')])[2]
    Click    xpath=(//button[contains(text(), 'Add to Cart')])

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
    Check Checkbox    *css=label >> id=EuroProtection
    Click    text=Cliff Diving
    Click    section[style="display: block;"] >> text=Next »


# Check Specific Step Status
#     # Check if entering vehicle data was successful
#     ${status_passed}    Run Keyword And Return Status    Enter Vehicle Data for Automobile
#     Log    Vehicle data entry passed: ${status_passed}

# End Test and Log Final Status
#     # Capture the overall test case status
#     ${final_status}    Set Variable If    '${TEST_STATUS}' == 'PASS'    PASS    FAIL

#     # Optionally, use your custom library to record the test status

End Test
    ${file_name} =    Set Variable    ${OUTPUT_DIR}${/}log.html
    Capture Test Case Status    ${TEST_NAME}    ${TEST_STATUS}    ${TEST_MESSAGE}    ${file_name}
    Close Browser
    Close Context

