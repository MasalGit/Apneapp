*** Settings ***
Documentation       Apneapp – Rekisteröintilomakkeen automaatiotestit
...                 Testaaja: Yamama | Branch: Yamama-FE
Library             Browser
Suite Setup         New Browser    chromium    headless=True
Suite Teardown      Close Browser

*** Variables ***
${REGISTER_URL}     file:///${CURDIR}/../register.html

*** Test Cases ***

TC1: Tyhjä lomake – kaikki kentät pakollisia
    [Documentation]    Tyhjällä lomakkeella rekisteröityminen näyttää pakollisuusvirheet
    New Page            ${REGISTER_URL}
    Click               id=submitBtn
    ${fn_err}=          Get Text    id=firstNameError
    Should Contain      ${fn_err}    pakollinen
    ${ln_err}=          Get Text    id=lastNameError
    Should Contain      ${ln_err}    pakollinen

TC2: Virheellinen sähköposti hylätään
    [Documentation]    Virheellinen sähköpostiosoite näyttää virheilmoituksen
    New Page            ${REGISTER_URL}
    Fill Text           id=firstName   Testi
    Fill Text           id=lastName    Kayttaja
    Fill Text           id=email       eiole
    Fill Text           id=password    salasana1
    Fill Text           id=confirmPassword    salasana1
    Click               id=submitBtn
    ${email_err}=       Get Text    id=emailError
    Should Contain      ${email_err}    Virheellinen

TC3: Liian lyhyt salasana hylätään (alle 8 merkkiä)
    [Documentation]    Alle 8 merkin salasana rekisteröinnissä hylätään
    New Page            ${REGISTER_URL}
    Fill Text           id=firstName   Testi
    Fill Text           id=lastName    Kayttaja
    Fill Text           id=email       kayttaja@email.fi
    Fill Text           id=password    abc1234
    Fill Text           id=confirmPassword    abc1234
    Click               id=submitBtn
    ${pw_err}=          Get Text    id=passwordError
    Should Contain      ${pw_err}    8 merkkiä

TC4: Erilaiset salasanat hylätään
    [Documentation]    Jos salasanat eivät täsmää, näytetään virheilmoitus
    New Page            ${REGISTER_URL}
    Fill Text           id=firstName   Testi
    Fill Text           id=lastName    Kayttaja
    Fill Text           id=email       kayttaja@email.fi
    Fill Text           id=password    salasana1
    Fill Text           id=confirmPassword    erilainen1
    Click               id=submitBtn
    ${confirm_err}=     Get Text    id=confirmPasswordError
    Should Contain      ${confirm_err}    täsmää

TC5: Puuttuva etunimi hylätään
    [Documentation]    Tyhjä etunimikenttä näyttää pakollisuusvirheen
    New Page            ${REGISTER_URL}
    Fill Text           id=lastName    Kayttaja
    Fill Text           id=email       kayttaja@email.fi
    Fill Text           id=password    salasana1
    Fill Text           id=confirmPassword    salasana1
    Click               id=submitBtn
    ${fn_err}=          Get Text    id=firstNameError
    Should Contain      ${fn_err}    pakollinen

TC6: Puuttuva sukunimi hylätään
    [Documentation]    Tyhjä sukunimikenttä näyttää pakollisuusvirheen
    New Page            ${REGISTER_URL}
    Fill Text           id=firstName   Testi
    Fill Text           id=email       kayttaja@email.fi
    Fill Text           id=password    salasana1
    Fill Text           id=confirmPassword    salasana1
    Click               id=submitBtn
    ${ln_err}=          Get Text    id=lastNameError
    Should Contain      ${ln_err}    pakollinen
