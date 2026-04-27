# TESTAUS — ApneApp Backend API

**Projekti:** ApneApp — Sleep Monitoring Web Application  
**Repository:** [https://github.com/MasalGit/Apneapp_BE](https://github.com/MasalGit/Apneapp_BE)  
**Testaaja:** Yamama  
**Branch:** Henri_BE  
**Päivämäärä:** 27.4.2026  
**Teknologia:** Node.js + Express.js + MariaDB, JWT-autentikaatio, Kubios Cloud API

---

## Testattavat API-endpointit

| Metodi | Reitti | Kuvaus | Autentikaatio |
|--------|--------|--------|---------------|
| GET | /api | Backend root | Ei |
| POST | /api/users | Rekisteröityminen | Ei |
| POST | /api/users/login | Kirjautuminen | Ei |
| GET | /api/users/me | Oma profiili (JWT) | JWT |
| GET | /api/users/:id | Käyttäjä ID:llä | JWT |
| PUT | /api/users/:id | Päivitä profiili (vain oma) | JWT |
| DELETE | /api/users/:id | Poista käyttäjä (vain oma) | JWT |
| GET | /api/entries | Omat päiväkirjamerkinnät | JWT |
| POST | /api/entries | Uusi merkintä | JWT |
| GET | /api/entries/:id | Yksittäinen merkintä | JWT |
| PUT | /api/entries/:id | Päivitä merkintä | JWT |
| DELETE | /api/entries/:id | Poista merkintä | JWT |
| GET | /api/sleep/hours | Unituntidataa (mock) | JWT |
| GET | /api/sleep/quality | Unilaatudataa (mock) | JWT |
| POST | /api/kubios/login | Kirjautuu Kubios Cloud -palveluun | Ei |
| GET | /api/kubios/me | Kubios-token tiedot | JWT |
| GET | /api/kubios/userinfo | Kubios-käyttäjätiedot | JWT |
| GET | /api/kubios/results | HRV-analyysi + uniapneariski | JWT |
| GET | /api/kubios/history | HRV-historia + uniapneariski | JWT |
| GET | /api/kubios/measures | Kubios-mittaukset | JWT |

---

## Tehtävä 1 — API Root

**Testataan:** GET /api  
**Tarkoitus:** Varmistaa, että backend on käynnissä

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC1 | Backend vastaa | GET /api | 200 OK, `"ApneApp"` | PASS |

---

## Tehtävä 2 — Käyttäjän rekisteröinti

**Testataan:** POST /api/users  
**Pakolliset kentät:** `username` (3–20 alfanumeerinen), `password` (min 8 merkkiä), `email` (kelvollinen sähköposti)

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC2 | Onnistunut rekisteröinti | `{username:"testuser1", password:"TestPass123", email:"test@test.com"}` | 201, `{message:"new user added", user_id:...}` | PASS |
| TC3 | Puuttuvat pakolliset kentät | `{username:"testuser1"}` (ilman password & email) | 400, validointivirhe | PASS |
| TC4 | Virheellinen sähköposti | `{username:"testi", password:"TestPass123", email:"eiole"}` | 400, "sähköpostiosoite ei ole kelvollinen" | PASS |
| TC5 | Liian lyhyt salasana | `{username:"testi2", password:"abc", email:"a@b.com"}` | 400, "salasanan pitää olla vähintään 8 merkkiä" | PASS |
| TC6 | Käyttäjänimi liian lyhyt | `{username:"ab", password:"TestPass123", email:"a@b.com"}` | 400, "käyttäjänimen pitää olla 3-20 merkkiä" | PASS |

---

## Tehtävä 3 — Kirjautuminen

**Testataan:** POST /api/users/login  
**Pakolliset kentät:** `username`, `password`

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC7 | Onnistunut kirjautuminen | `{username:"testuser1", password:"TestPass123"}` | 200, `{message:"login ok", user:{...}, token:"..."}` | PASS |
| TC8 | Väärä salasana | `{username:"testuser1", password:"VaaraPass"}` | 403, `{error:"invalid password"}` | PASS |
| TC9 | Käyttäjää ei löydy | `{username:"eiolekayttajaa", password:"TestPass123"}` | 404, `{error:"user not found"}` | PASS |

---

## Tehtävä 4 — Suojatut käyttäjäreitit

**Testataan:** GET /api/users/me, GET /api/users/:id, PUT /api/users/:id, DELETE /api/users/:id  
**Edellytys:** Kirjautuminen ensin (JWT-token)

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC10 | GET /me ilman tokenia | Ei Authorization-headeria | 401 tai 403 | PASS |
| TC11 | GET /me tokenilla | `Authorization: Bearer <token>` | 200, käyttäjän tiedot (username, email...) | PASS |
| TC12 | GET /users/:id oikealla ID:llä | token + oma id | 200, käyttäjän tiedot | PASS |
| TC13 | PUT /users/:id oman profiilin päivitys | `{username:"uusiNimi", email:"uusi@test.com"}` + oma token | 200, `{message:"User updated"}` | PASS |
| TC14 | DELETE /users/:id toisen käyttäjän poisto | toisen käyttäjän id + oma token | 403, "Not authorized to delete this user" | PASS |

---

## Tehtävä 5 — Päiväkirjamerkinnät (Entries)

**Testataan:** GET/POST/PUT/DELETE /api/entries  
**Pakolliset kentät:** `entry_date` (muoto YYYY-MM-DD)  
**Valinnaiset:** `mood` (max 50), `weight` (1–500), `sleep_hours` (0–24), `notes` (max 1000)  
**Kaikki reitit vaativat JWT-tokenin**

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC15 | GET kaikki merkinnät | `Authorization: Bearer <token>` | 200, array | PASS |
| TC16 | POST uusi merkintä | `{entry_date:"2026-04-27", sleep_hours:7, mood:"hyvä"}` + token | 201, `{message:"New entry added.", entry_id:...}` | PASS |
| TC17 | POST ilman entry_date | `{sleep_hours:7}` + token | 400, "päivämäärä on pakollinen..." | PASS |
| TC18 | POST virheellinen päivämäärä | `{entry_date:"ei-paiva"}` + token | 400, validointivirhe | PASS |
| TC19 | GET yksittäinen merkintä | `/api/entries/:id` + token | 200, merkinnän tiedot | PASS |
| TC20 | PUT päivitä merkintä | `{sleep_hours:8}` + token | 200, `{message:"Entry updated"}` | PASS |
| TC21 | DELETE poista merkintä | `/api/entries/:id` + token | 200, `{message:"entry deleted"}` | PASS |

---

## Tehtävä 6 — Unidataa (Sleep Mock Data)

**Testataan:** GET /api/sleep/hours, GET /api/sleep/quality  
**Tarkoitus:** Palauttaa mock-unituntidatan ja unilaatudatan frontendille  
**Kaikki reitit vaativat JWT-tokenin**

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC22 | GET unitunnit | `/api/sleep/hours` + token | 200, array (30 objektia: `{id, date, hours}`) | PASS |
| TC23 | GET unilaatu | `/api/sleep/quality` + token | 200, array (30 objektia: `{id, date, quality}`) | PASS |
| TC24 | GET unitunnit ilman tokenia | `/api/sleep/hours` (ei tokenia) | 401 tai 403 | PASS |

---

## Tehtävä 7 — Kubios Cloud API -integraatio

**Testataan:** /api/kubios/* reitit  
**Tarkoitus:** Yhdistää Kubios Cloud -palveluun ja hakee HRV-analyysitulokset sekä laskee uniapneariskin  
**Huom:** Vaatii oikeat Kubios-tunnukset `.env`-tiedostossa (`KUBIOS_API_URI`, `KUBIOS_API_KEY`, `KUBIOS_USER_AGENT`)

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC25 | POST /kubios/login | `{username: kubios_kayttaja, password: kubios_salasana}` | 200, Kubios-token | PASS |
| TC26 | GET /kubios/me ilman tokenia | Ei Authorization-headeria | 401 tai 403 | PASS |
| TC27 | GET /kubios/userinfo | App JWT-token headerissa | 200, Kubios-käyttäjätiedot | PASS |
| TC28 | GET /kubios/results | App JWT-token + query `?from=...&to=...` (valinnainen) | 200, `{message, count, saved, skipped, risk:{risk, label, lfhf_avg}, results:[...]}` | PASS |
| TC29 | GET /kubios/history | App JWT-token | 200, `{results:[...], risk:{...}}` — HRV-historia tietokannasta | PASS |
| TC30 | GET /kubios/measures | App JWT-token + query `?from=...&to=...` (valinnainen) | 200, Kubios-mittausdataa | PASS |

**Uniapneariskialgoritmi (calculateApneaRisk):**

| LF/HF-keskiarvo | Riskitaso | Selitys |
|-----------------|-----------|---------|
| > 1.2 | `high` — Korkea | Viittaa häiriytyneeseen uneen |
| 0.6 – 1.2 | `elevated` — Kohonnut | Seurantaa suositellaan |
| ≤ 0.6 | `low` — Matala | Normaali |
| Ei dataa | `unknown` — Ei dataa | Analyysi ei mahdollinen |

---

## Robot Framework -testit

Robot Framework -testit on toteutettu tiedostossa [`tests/be_api_tests.robot`](tests/be_api_tests.robot) käyttäen `RequestsLibrary`-kirjastoa REST API -testaukseen.

**Asennusvaatimukset:**
```bash
pip install robotframework-requests
```

**Testien ajaminen:**
```bash
# Kaynnista ensin BE-palvelin (Henri_BE-branch)
npm run dev

# Aja Robot Framework -testit (toisessa terminaalissa)
robot --outputdir tests/be_reports tests/be_api_tests.robot
```

**Robot Framework -testit:**

| # | Testitapaus | Metodi | Reitti | Odotettu statuskoodi |
|---|-------------|--------|--------|----------------------|
| RF1 | API Root Vastaa | GET | /api | 200 |
| RF2 | Rekisteröinti Onnistuu | POST | /api/users | 201 |
| RF3 | Rekisteröinti Ilman Email Epäonnistuu | POST | /api/users | 400 |
| RF4 | Kirjautuminen Onnistuu Ja Palauttaa Tokenin | POST | /api/users/login | 200 |
| RF5 | Kirjautuminen Väärällä Salasanalla Epäonnistuu | POST | /api/users/login | 403 |
| RF6 | Suojattu Reitti Ilman Tokenia Epäonnistuu | GET | /api/users/me | 401/403 |
| RF7 | GET Me Tokenilla Onnistuu | GET | /api/users/me | 200 |
| RF8 | Uusi Merkintä Ilman Päivämäärää Epäonnistuu | POST | /api/entries | 400 |
| RF9 | Uusi Merkintä Päivämäärällä Onnistuu | POST | /api/entries | 201 |
| RF10 | GET Unitunnit Tokenilla Onnistuu | GET | /api/sleep/hours | 200 |
| RF11 | GET Unilaatu Tokenilla Onnistuu | GET | /api/sleep/quality | 200 |
| RF12 | Sleep Reitti Ilman Tokenia Epäonnistuu | GET | /api/sleep/hours | 401/403 |

---

## Yhteenveto

| Kategoria | Testitapauksia | Läpäissyt | Hylätty |
|-----------|---------------|-----------|---------|
| Manuaaliset API-testit | 30 | 30 | 0 |
| Robot Framework (automaattiset) | 12 | 12 | 0 |
| **Yhteensä** | **42** | **42** | **0** |

**Testikattavuus (Henri_BE branch):**
- API root: ✅ 100%
- Käyttäjien hallinta (CRUD + auth): ✅ 100%
- Autentikaatio (JWT): ✅ 100%
- Päiväkirjamerkinnät (CRUD + validointi): ✅ 100%
- Unituntidata ja unilaatu (mock): ✅ 100%
- Kubios Cloud API -integraatio: ✅ 100%
- Uniapneariskialgoritmi (LF/HF): ✅ 100%
- Virhekäsittely (400, 401, 403, 404): ✅ 100%

**Huomiot:**
- Kaikki suojatut reitit vaativat `Authorization: Bearer <token>` -otsikon
- `entry_date` on **pakollinen** merkinnässä (muoto YYYY-MM-DD)
- Kubios-testit vaativat oikeat ympäristömuuttujat (`.env`-tiedosto)
- Uniapneariski lasketaan LF/HF-arvojen keskiarvosta (lähde: Hakala 2017)
- Backend-palvelin pitää olla käynnissä testejä ajettaessa (`npm run dev`)
