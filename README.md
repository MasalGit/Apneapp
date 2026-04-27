# Apneapp – Frontend

**Projekti:** Terveyssovelluksen kehitys  
**Kurssi:** Ohjelmistotestaus – Ryhmätehtävät  
**Koulu:** Metropolia AMK  
**Branch:** `Yamama-FE`  
**Testaaja:** Yamama

---

## Projektin kuvaus

Apneapp on web-pohjainen uniapnean seurantasovellus. Frontend sisältää kirjautumis-, rekisteröinti- ja dashboard-sivut sekä kaavionäkymän.

---

## Testausdokumentaatio

| Dokumentti | Kuvaus |
|---|---|
| [TESTAUS.md](apneapp-login/TESTAUS.md) | Yamama-FE – yksikkö- ja automaatiotestit (48 JS + 12 Robot Framework) |
| [TESTAUS_Paavo.md](apneapp-login/TESTAUS_Paavo.md) | Paavo_FE2 – validointitestit |
| [TESTAUS_Henri.md](apneapp-login/TESTAUS_Henri.md) | Henri_FE – validointitestit |

---

## HTML-testiraportit

| Raportti | Avaa selaimessa |
|---|---|
| JS-yksikkötestit (Yamama) | [tests/tests.html](apneapp-login/tests/tests.html) |
| JS-yksikkötestit (Paavo) | [tests/tests_Paavo.html](apneapp-login/tests/tests_Paavo.html) |
| JS-yksikkötestit (Henri) | [tests/tests_Henri.html](apneapp-login/tests/tests_Henri.html) |
| RF – Kirjautuminen (report) | [tests/reports/report.html](apneapp-login/tests/reports/report.html) |
| RF – Kirjautuminen (log) | [tests/reports/log.html](apneapp-login/tests/reports/log.html) |
| RF – Rekisteröinti (report) | [tests/reports/register_report.html](apneapp-login/tests/reports/register_report.html) |
| RF – Rekisteröinti (log) | [tests/reports/register_log.html](apneapp-login/tests/reports/register_log.html) |

---

## Robot Framework – Automaatiotestit

| Testitiedosto | Kuvaus |
|---|---|
| [tests/login_tests.robot](apneapp-login/tests/login_tests.robot) | Kirjautumislomakkeen automaatiotestit (6 TC) |
| [tests/register_tests.robot](apneapp-login/tests/register_tests.robot) | Rekisteröintilomakkeen automaatiotestit (6 TC) |

### Testien ajaminen

```bash
pip install robotframework robotframework-browser
rfbrowser init

robot apneapp-login/tests/login_tests.robot
robot apneapp-login/tests/register_tests.robot
```

---

## Backend-testausdokumentaatio

| Dokumentti | Kuvaus |
|---|---|
| [TESTAUS_BE.md](apneapp-login/TESTAUS_BE.md) | Backend API-testit (28 manuaalinen + 12 Robot Framework) |
| [tests/be_api_tests.robot](apneapp-login/tests/be_api_tests.robot) | Robot Framework API-testit (12 TC, RequestsLibrary) |

### BE-testien ajaminen

```bash
pip install robotframework-requests

# Kaynnista BE-palvelin (Apneapp_BE-hakemistossa)
npm run dev

# Aja API-testit (toisessa terminaalissa)
robot --outputdir apneapp-login/tests/be_reports apneapp-login/tests/be_api_tests.robot
```

---

## Testitulokset

| | Tulos |
|---|---|
| JS yksikkötestit (FE) | ✅ 48 / 48 läpäisty |
| Robot Framework – UI (FE) | ✅ 12 / 12 läpäisty |
| Manuaaliset API-testit (BE) | ✅ 28 / 28 läpäisty |
| Robot Framework – API (BE) | 12 TC (vaatii käynnissä olevan BE-palvelimen) |

---

## Projektin rakenne

```
Apneapp_FE/
├── apneapp-login/
│   ├── index.html          ← Kirjautuminen
│   ├── register.html       ← Rekisteröinti
│   ├── dashboard.html      ← Dashboard
│   ├── script.js           ← Logiikka
│   ├── TESTAUS.md          ← Testausdokumentti (Yamama)
│   ├── TESTAUS_Paavo.md    ← Testausdokumentti (Paavo_FE2)
│   ├── TESTAUS_BE.md       ← Testausdokumentti (Backend API)
│   └── tests/
│       ├── tests.html
│       ├── tests_Paavo.html
│       ├── tests_Henri.html
│       ├── login_tests.robot
│       ├── register_tests.robot
│       └── be_api_tests.robot
└── Apneapp/
    └── graph.html          ← Kaavionäkymä
```
