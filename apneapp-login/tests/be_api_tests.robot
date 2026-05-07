*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

Suite Setup    Alusta Testit
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       http://localhost:3000/api
${TOKEN}          ${EMPTY}
${USER_ID}        ${EMPTY}
${KUBIOS_USER}    elsikubios@gmail.com
${KUBIOS_PASS}    hYr062vQh6

*** Keywords ***
Alusta Testit
    Create Session    apneapp    ${BASE_URL}    verify=False
    # Kirjaudu Kubios-tunnuksilla ja hae token (POST /api/users ja /login poistettu)
    ${login_body}=    Create Dictionary    username=${KUBIOS_USER}    password=${KUBIOS_PASS}
    ${login_resp}=    POST On Session    apneapp    /kubios/login    json=${login_body}    expected_status=any
    ${json}=    Set Variable    ${login_resp.json()}
    Set Suite Variable    ${TOKEN}    ${json['token']}

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
# Tehtava 2: Kubios-kirjautuminen
# -----------------------------------------------

Kubios Login Onnistuu Ja Palauttaa Tokenin
    [Documentation]    POST /api/kubios/login oikeilla tunnuksilla → 200 + token
    [Tags]    kubios    login
    ${body}=    Create Dictionary    username=${KUBIOS_USER}    password=${KUBIOS_PASS}
    ${response}=    POST On Session    apneapp    /kubios/login    json=${body}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    token
    Should Not Be Empty    ${json['token']}

# -----------------------------------------------
# Tehtava 3: Suojatut kayttajareitit
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

# -----------------------------------------------
# Tehtava 6: Kayttajan haku ID:lla ja profiilin paivitys
# -----------------------------------------------

GET Kayttaja ID Tokenilla Onnistuu
    [Documentation]    GET /api/users/:id omalla tokenilla → 200, kayttajan tiedot
    [Tags]    users    auth
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /users/${USER_ID}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Should Contain    ${body}    username

PUT Profiilin Paivitys Onnistuu
    [Documentation]    PUT /api/users/:id oman profiilin paivitys → 200
    [Tags]    users    auth
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${rand}=    Generate Random String    4    [NUMBERS]
    ${body}=    Create Dictionary    username=updated${rand}    email=updated${rand}@test.com
    ${response}=    PUT On Session    apneapp    /users/${USER_ID}    json=${body}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200

# -----------------------------------------------
# Tehtava 7: Kubios Cloud API - lisatestit
# -----------------------------------------------

GET Kubios Me Tokenilla Onnistuu
    [Documentation]    GET /api/kubios/me tokenilla → 200, Kubios-token tiedot
    [Tags]    kubios    auth
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /kubios/me    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200

GET Kubios UserInfo Tokenilla Onnistuu
    [Documentation]    GET /api/kubios/userinfo tokenilla → 200, Kubios-kayttajatiedot
    [Tags]    kubios
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /kubios/userinfo    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200

GET Kubios Sync Tokenilla Onnistuu
    [Documentation]    GET /api/kubios/sync tokenilla → 200, synced + skipped
    [Tags]    kubios
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=    GET On Session    apneapp    /kubios/sync    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    synced
    Dictionary Should Contain Key    ${body}    skipped
