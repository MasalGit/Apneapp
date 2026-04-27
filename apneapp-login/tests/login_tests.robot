*** Settings ***
Documentation       Apneapp – Kirjautumislomakkeen automaatiotestit
...                 Testaaja: Yamama | Branch: Yamama-FE
Library             Browser
Suite Setup         New Browser    chromium    headless=True
Suite Teardown      Close Browser

*** Variables ***
${LOGIN_URL}        file:///${CURDIR}/../index.html

*** Test Cases ***

TC1: Tyhjä lomake – sähköposti ja salasana pakollisia
    [Documentation]    Tyhjällä lomakkeella kirjautuminen näyttää pakollisuusvirheet
    New Page            ${LOGIN_URL}
    Click               id=submitBtn
    ${email_err}=       Get Text    id=emailError
    Should Contain      ${email_err}    pakollinen
    ${pw_err}=          Get Text    id=passwordError
    Should Contain      ${pw_err}    pakollinen

TC2: Virheellinen sähköposti näyttää virheilmoituksen
    [Documentation]    Sähköposti ilman @-merkkiä hylätään
    New Page            ${LOGIN_URL}
    Fill Text           id=email      eiole
    Fill Text           id=password   salasana1
    Click               id=submitBtn
    ${email_err}=       Get Text    id=emailError
    Should Contain      ${email_err}    Virheellinen

TC3: Sähköposti ilman pistettä hylätään
    [Documentation]    Sähköposti ilman domainpistettä hylätään
    New Page            ${LOGIN_URL}
    Fill Text           id=email      kayttaja@esimerkki
    Fill Text           id=password   salasana1
    Click               id=submitBtn
    ${email_err}=       Get Text    id=emailError
    Should Contain      ${email_err}    Virheellinen

TC4: Liian lyhyt salasana hylätään
    [Documentation]    Alle 6 merkin salasana näyttää virheilmoituksen
    New Page            ${LOGIN_URL}
    Fill Text           id=email      kayttaja@email.fi
    Fill Text           id=password   abc
    Click               id=submitBtn
    ${pw_err}=          Get Text    id=passwordError
    Should Contain      ${pw_err}    6 merkkiä

TC5: Tyhjä salasana hylätään
    [Documentation]    Tyhjä salasanakenttä näyttää pakollisuusvirheen
    New Page            ${LOGIN_URL}
    Fill Text           id=email      kayttaja@email.fi
    Click               id=submitBtn
    ${pw_err}=          Get Text    id=passwordError
    Should Contain      ${pw_err}    pakollinen

TC6: Oikeilla arvoilla ei validointivirheitä
    [Documentation]    Oikea sähköposti ja pitkä salasana eivät tuota validointivirheitä
    New Page            ${LOGIN_URL}
    Fill Text           id=email      kayttaja@email.fi
    Fill Text           id=password   salasana1
    Click               id=submitBtn
    ${email_err}=       Get Text    id=emailError
    Should Be Empty     ${email_err}
    ${pw_err}=          Get Text    id=passwordError
    Should Be Empty     ${pw_err}
