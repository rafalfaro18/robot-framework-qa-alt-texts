*** Settings ***

Library  SeleniumLibrary
Library  Collections
Library  String

*** Variables ***

${URL}    http://hoteldev.staging.wpengine.com
${adminpage}    ${URL}/wp-admin
${time}      10s
${nav}      Chrome

${imgurl}    ${URL}/wp-content/uploads/2018/02/Contact_Global_AlliHelminski_220x220.jpg
${imgalt}     Profile picture of Alli Helminski
*** Test Cases ***

Verificar que Alt Text de imagen en varias paginas sea el mismo
    [Documentation]    Verificar que alt text sea ${imgalt}
    Open Browser   ${URL}   ${nav}
    BuiltIn.Sleep    500ms
    @{pagesToFix}  Create List      north-america/  europe/   middle-east-and-africa/  asia-pacific/  caribbean-and-latin-america/
    Loop List Copy   @{pagesToFix}

    Close Browser



*** Keywords ***


Dormir
    BuiltIn.Sleep   ${time}


Loop List Copy
    [Arguments]    @{pages}
        :FOR   ${j}   IN   @{pages}
            \    Go To    ${URL}/${j}
            \    Page Should Contain Image      ${imgurl}
            \    ${alt} =     Get Element Attribute         css:img[src="${imgurl}"]         alt
            \    Should Be Equal    ${alt}        ${imgalt}
