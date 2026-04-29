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
# Tehtava 5: Kubios Cloud API
# -----------------------------------------------

Kubios Reitti Ilman Tokenia Epaonnistuu
    [Documentation]    GET /api/kubios/me ilman Authorization-headeria → 401 tai 403
    [Tags]    kubios    auth
    ${response}=    GET On Session    apneapp    /kubios/me    expected_status=any
    Should Be True    ${response.status_code} == 401 or ${response.status_code} == 403

GET Kubios History Tokenilla Onnistuu
    [Documentation]    GET /api/kubios/history tokenilla → 200, {results:[...]}
    [Tags]    kubios
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /kubios/history    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    results

GET Kubios Measures Tokenilla Onnistuu
    [Documentation]    GET /api/kubios/measures tokenilla → 200 (Kubios Cloud data)
    [Tags]    kubios
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /kubios/measures    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200

GET Kubios Sync Ilman Tokenia Epaonnistuu
    [Documentation]    GET /api/kubios/sync ilman tokenia → 401 tai 403
    [Tags]    kubios    auth
    ${response}=    GET On Session    apneapp    /kubios/sync    expected_status=any
    Should Be True    ${response.status_code} == 401 or ${response.status_code} == 403

Kayttajan Poisto Toisen Tunnuksella Epaonnistuu
    [Documentation]    DELETE /api/users/:id toisen kayttajan ID → 403
    [Tags]    users    auth
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    DELETE On Session    apneapp    /users/9999999    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    403
