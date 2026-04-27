*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

Suite Setup    Alusta Testit
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}    http://localhost:3000/api
${TOKEN}       ${EMPTY}
${USER_ID}     ${EMPTY}
${ENTRY_ID}    ${EMPTY}

*** Keywords ***
Alusta Testit
    Create Session    apneapp    ${BASE_URL}    verify=False
    # Luo uniikki testikayttaja
    ${rand}=    Generate Random String    6    [NUMBERS]
    Set Suite Variable    ${TEST_USER}    testuser${rand}
    Set Suite Variable    ${TEST_PASS}    TestPass123
    Set Suite Variable    ${TEST_EMAIL}    testuser${rand}@test.com
    # Rekisteroi testikayttaja
    ${body}=    Create Dictionary    username=${TEST_USER}    password=${TEST_PASS}    email=${TEST_EMAIL}
    ${reg_resp}=    POST On Session    apneapp    /users    json=${body}    expected_status=any
    # Kirjaudu sisaan ja tallenna token
    ${login_body}=    Create Dictionary    username=${TEST_USER}    password=${TEST_PASS}
    ${login_resp}=    POST On Session    apneapp    /users/login    json=${login_body}    expected_status=any
    ${json}=    Set Variable    ${login_resp.json()}
    Set Suite Variable    ${TOKEN}    ${json['token']}
    Set Suite Variable    ${USER_ID}    ${json['user']['user_id']}

*** Test Cases ***
# -----------------------------------------------
# Tehtava 1: API Root
# -----------------------------------------------

API Root Vastaa
    [Documentation]    GET /api → 200, "ApneApp"
    [Tags]    api
    ${response}=    GET On Session    apneapp    ${EMPTY}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200

# -----------------------------------------------
# Tehtava 2: Kayttajan rekisterointi
# -----------------------------------------------

Rekisterointi Onnistuu
    [Documentation]    POST /api/users uudella kayttajalla → 201
    [Tags]    users    register
    ${rand}=    Generate Random String    6    [NUMBERS]
    ${body}=    Create Dictionary
    ...    username=newuser${rand}
    ...    password=TestPass123
    ...    email=newuser${rand}@test.com
    ${response}=    POST On Session    apneapp    /users    json=${body}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    201

Rekisterointi Ilman Email Epaonnistuu
    [Documentation]    POST /api/users ilman email-kenttaa → 400
    [Tags]    users    register
    ${body}=    Create Dictionary    username=noemailuser    password=TestPass123
    ${response}=    POST On Session    apneapp    /users    json=${body}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    400

# -----------------------------------------------
# Tehtava 3: Kirjautuminen
# -----------------------------------------------

Kirjautuminen Onnistuu Ja Palauttaa Tokenin
    [Documentation]    POST /api/users/login oikeilla tiedoilla → 200 + JWT-token
    [Tags]    users    login
    ${body}=    Create Dictionary    username=${TEST_USER}    password=${TEST_PASS}
    ${response}=    POST On Session    apneapp    /users/login    json=${body}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    token
    Should Not Be Empty    ${json['token']}

Kirjautuminen Vaaralla Salasanalla Epaonnistuu
    [Documentation]    POST /api/users/login vaaralla salasanalla → 403
    [Tags]    users    login
    ${body}=    Create Dictionary    username=${TEST_USER}    password=WrongPass999
    ${response}=    POST On Session    apneapp    /users/login    json=${body}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    403

# -----------------------------------------------
# Tehtava 4: Suojatut kayttajareitit
# -----------------------------------------------

Suojattu Reitti Ilman Tokenia Epaonnistuu
    [Documentation]    GET /api/users/me ilman Authorization-headeria → 401 tai 403
    [Tags]    users    auth
    ${response}=    GET On Session    apneapp    /users/me    expected_status=any
    Should Be True    ${response.status_code} == 401 or ${response.status_code} == 403

GET Me Tokenilla Onnistuu
    [Documentation]    GET /api/users/me oikealla tokenilla → 200, kayttajan tiedot
    [Tags]    users    auth
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /users/me    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Should Contain    ${body}    username

# -----------------------------------------------
# Tehtava 5: Paivakirjamerkinnat (Entries)
# -----------------------------------------------

Uusi Merkinta Ilman Paivamaaran Epaonnistuu
    [Documentation]    POST /api/entries ilman entry_date → 400 (pakollinen kentta)
    [Tags]    entries
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${body}=    Create Dictionary    sleep_hours=${7}    mood=hyvä
    ${response}=    POST On Session    apneapp    /entries    json=${body}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    400

Uusi Merkinta Paivamaaran Kanssa Onnistuu
    [Documentation]    POST /api/entries entry_date pakollisena → 201
    [Tags]    entries
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${body}=    Create Dictionary    entry_date=2026-04-27    sleep_hours=${7}    mood=hyvä    notes=RF-testi
    ${response}=    POST On Session    apneapp    /entries    json=${body}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    entry_id
    Set Suite Variable    ${ENTRY_ID}    ${json['entry_id']}

# -----------------------------------------------
# Tehtava 6: Unidata (Sleep Mock Data)
# -----------------------------------------------

GET Unitunnit Tokenilla Onnistuu
    [Documentation]    GET /api/sleep/hours → 200, array unituntidataa
    [Tags]    sleep
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /sleep/hours    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${body}

GET Unilaatu Tokenilla Onnistuu
    [Documentation]    GET /api/sleep/quality → 200, array unilaatudataa
    [Tags]    sleep
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /sleep/quality    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${body}

Sleep Reitti Ilman Tokenia Epaonnistuu
    [Documentation]    GET /api/sleep/hours ilman tokenia → 401 tai 403
    [Tags]    sleep
    ${response}=    GET On Session    apneapp    /sleep/hours    expected_status=any
    Should Be True    ${response.status_code} == 401 or ${response.status_code} == 403
