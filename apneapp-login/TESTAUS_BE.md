# TESTAUS — ApneApp Backend API

**Projekti:** ApneApp — Sleep Monitoring Web Application  
**Repository:** [https://github.com/MasalGit/Apneapp_BE](https://github.com/MasalGit/Apneapp_BE)  
**Testaaja:** Yamama  
**Branch:** Henri_BE  
**Päivämäärä:** 29.4.2026  
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
| POST | /api/kubios/login | Kirjautuu Kubios Cloud -palveluun | Ei |
| GET | /api/kubios/me | Kubios-token tiedot | JWT |
| GET | /api/kubios/userinfo | Kubios-käyttäjätiedot | JWT |
| GET | /api/kubios/history | Tallennetut mittaukset tietokannasta | JWT |
| GET | /api/kubios/measures | Kubios-mittaukset suoraan pilvestä | JWT |
| GET | /api/kubios/sync | Synkronoi RRI-mittaukset + uniapnea-analyysi | JWT |

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

## Tehtävä 5 — Kubios Cloud API -integraatio

**Testataan:** /api/kubios/* reitit  
**Tarkoitus:** Yhdistää Kubios Cloud -palveluun, synkronoi RRI-mittaukset ja laskee uniapneariskin  
**Huom:** Vaatii oikeat Kubios-tunnukset `.env`-tiedostossa (`KUBIOS_API_URI`, `KUBIOS_API_KEY`, `KUBIOS_USER_AGENT`)

| # | Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|-------------|-------|----------------|-------|
| TC15 | POST /kubios/login | `{username: kubios_kayttaja, password: kubios_salasana}` | 200, Kubios-token | PASS |
| TC16 | GET /kubios/me ilman tokenia | Ei Authorization-headeria | 401 tai 403 | PASS |
| TC17 | GET /kubios/me tokenilla | App JWT-token headerissa | 200, Kubios-token tiedot | PASS |
| TC18 | GET /kubios/userinfo | App JWT-token headerissa | 200, Kubios-käyttäjätiedot | PASS |
| TC19 | GET /kubios/measures | App JWT-token + query `?from=...&to=...` (valinnainen) | 200, Kubios-mittausdataa pilvestä | PASS |
| TC20 | GET /kubios/history | App JWT-token | 200, `{results:[...]}` — tallennetut mittaukset tietokannasta | PASS |
| TC21 | GET /kubios/sync | App JWT-token | 200, `{message:"Synkronointi valmis", synced:N, skipped:N}` — hakee RRI-dataa, analysoi ja tallentaa | PASS |
| TC22 | GET /kubios/sync ilman tokenia | Ei Authorization-headeria | 401 tai 403 | PASS |

**Synkronointilogiikka (/api/kubios/sync):**
- Hakee kaikki finalized RRI-mittaukset Kubios Cloudista
- Ohittaa mittaukset joiden kesto < 3 tuntia (10800 s)
- Analysoi RRI-arvot `analyzeRRI`-palvelulla (LF/HF)
- Tallentaa tulokset tietokantaan

**Uniapneariskialgoritmi (LF/HF-keskiarvo):**

| LF/HF-keskiarvo | Riskitaso |
|-----------------|-----------|
| < 0.7 | `normal` — Normaali |
| 0.7 – 1.2 | `elevated` — Kohonnut |
| ≥ 1.2 | `high` — Korkea |

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
| RF8 | Kubios Reitti Ilman Tokenia Epäonnistuu | GET | /api/kubios/me | 401/403 |
| RF9 | GET Kubios History Tokenilla Onnistuu | GET | /api/kubios/history | 200 |
| RF10 | GET Kubios Measures Tokenilla Onnistuu | GET | /api/kubios/measures | 200 |
| RF11 | GET Kubios Sync Ilman Tokenia Epäonnistuu | GET | /api/kubios/sync | 401/403 |
| RF12 | Käyttäjän Poisto Toisen Tunnuksella Epäonnistuu | DELETE | /api/users/:id | 403 |

---

## Yhteenveto

| Kategoria | Testitapauksia | Läpäissyt | Hylätty |
|-----------|---------------|-----------|---------|
| Manuaaliset API-testit | 22 | 22 | 0 |
| Robot Framework (automaattiset) | 12 | 12 | 0 |
| **Yhteensä** | **34** | **34** | **0** |

**Testikattavuus (Henri_BE branch — päivitetty 29.4.2026):**
- API root: ✅ 100%
- Käyttäjien hallinta (CRUD + auth): ✅ 100%
- Autentikaatio (JWT): ✅ 100%
- Kubios Cloud API -integraatio: ✅ 100%
- RRI-synkronointi ja uniapnea-analyysi: ✅ 100%
- Virhekäsittely (400, 401, 403, 404): ✅ 100%

**Huomiot:**
- Kaikki suojatut reitit vaativat `Authorization: Bearer <token>` -otsikon
- `entry_date` on **pakollinen** merkinnässä (muoto YYYY-MM-DD)
- Kubios-testit vaativat oikeat ympäristömuuttujat (`.env`-tiedosto)
- Uniapneariski lasketaan LF/HF-arvojen keskiarvosta (lähde: Hakala 2017)
- Backend-palvelin pitää olla käynnissä testejä ajettaessa (`npm run dev`)
