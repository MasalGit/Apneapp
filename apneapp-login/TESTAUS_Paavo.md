# Apneapp – Testausdokumentti

**Testaaja:** Yamama  
**Päivämäärä:** 26.4.2026  
**Branch:** `Paavo_FE2`

---

## Tehtävä 1 – isValidEmail() – Sähköpostin validointi

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Oikea sähköposti | `kayttaja@esimerkki.fi` | `true` |
| 2 | Gmail-osoite | `testi@gmail.com` | `true` |
| 3 | Tyhjä merkkijono | *(tyhjä)* | `false` |
| 4 | Puuttuu @-merkki | `kayttajaesimerkki.fi` | `false` |
| 5 | Puuttuu piste | `kayttaja@esimerkki` | `false` |
| 6 | Puuttuu käyttäjätunnus | `@esimerkki.fi` | `false` |
| 7 | Välilyönti osoitteessa | `kayttaja @esimerkki.fi` | `false` |

---

## Tehtävä 2 – Salasanan validointi (kirjautuminen, min 6 merkkiä)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 6 merkkiä | `abc123` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 5 merkkiä | `abc12` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 3 – Salasanan validointi (rekisteröinti, min 8 merkkiä)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 8 merkkiä | `abc12345` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 7 merkkiä | `abc1234` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 4 – passwordsMatch() – Salasanojen täsmäys (rekisteröinti)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Samat salasanat | `abc12345` / `abc12345` | `true` |
| 2 | Erilaiset salasanat | `abc12345` / `xyz99999` | `false` |
| 3 | Molemmat tyhjiä | *(tyhjä)* / *(tyhjä)* | `true` |
| 4 | Iso/pieni kirjain | `Salasana1` / `salasana1` | `false` |

---

## Tehtävä 5 – isEmpty() – Nimen tyhjyystarkistus

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Tyhjä merkkijono | *(tyhjä)* | `true` |
| 2 | Pelkät välilyönnit | `   ` | `true` |
| 3 | Normaali etunimi | `Paavo` | `false` |
| 4 | Numero | `0` | `false` |

---

## Tehtävä 6 – validateLoginForm() – Kirjautumislomakkeen validointi

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Oikea sähköposti + vahva salasana | `kayttaja@email.fi` / `salasana1` | `true` |
| 2 | Väärä sähköposti | `eiole` / `salasana1` | `false` |
| 3 | Liian lyhyt salasana | `kayttaja@email.fi` / `abc` | `false` |
| 4 | Molemmat väärät | *(tyhjä)* / *(tyhjä)* | `false` |
| 5 | Tyhjä sähköposti | *(tyhjä)* / `salasana1` | `false` |

---

## Tehtävä 7 – calculateRiskFromQuality() – Riskiarvion laskenta (graph.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Huonoin laatu (1.0) | `1.0` | `100` |
| 2 | Paras laatu (2.0) | `2.0` | `50` |
| 3 | Keskiarvo (1.5) | `1.5` | `75` |
| 4 | Korkea laatu (1.2) | `1.2` | `90` |
| 5 | Nollatulos (3.0) | `3.0` | `0` |

---

## Tehtävä 8 – processData() – Datan käsittely kaaviolle (graph.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | 1 päivä, 1 merkintä | hours: `[{date, hours:7}]`, quality: `[{date, quality:2.0}]`, days: `1` | sleepHours: `[7]`, riskScores: `[50]` |
| 2 | Tyhjät taulukot | `[]` / `[]`, days: `7` | labels: `[]`, sleepHours: `[]`, riskScores: `[]` |
| 3 | days > saatavilla oleva data | 2 merkintää, days: `10` | palauttaa molemmat merkinnät |

---

## Robot Framework – Automaatiotestit

Sovelluksen lomakkeet on testattu myös **Browser-kirjastolla** automaattisesti selaimessa.

### Kirjautumislomake – [login_tests.robot](tests/login_tests.robot)

| # | Testitapaus | Odotettu tulos |
|---|---|---|
| TC1 | Tyhjä lomake – sähköposti ja salasana pakollisia | Virheilmoitukset näkyvät |
| TC2 | Virheellinen sähköposti hylätään | `"Virheellinen sähköpostiosoite"` |
| TC3 | Sähköposti ilman pistettä hylätään | `"Virheellinen sähköpostiosoite"` |
| TC4 | Liian lyhyt salasana hylätään | `"vähintään 6 merkkiä"` |
| TC5 | Tyhjä salasana hylätään | `"Salasana on pakollinen"` |
| TC6 | Oikeilla arvoilla ei validointivirheitä | Ei virheilmoituksia |

### Rekisteröintilomake – [register_tests.robot](tests/register_tests.robot)

| # | Testitapaus | Odotettu tulos |
|---|---|---|
| TC1 | Tyhjä lomake – kaikki kentät pakollisia | Virheilmoitukset näkyvät |
| TC2 | Virheellinen sähköposti hylätään | `"Virheellinen sähköpostiosoite"` |
| TC3 | Liian lyhyt salasana hylätään (alle 8) | `"vähintään 8 merkkiä"` |
| TC4 | Erilaiset salasanat hylätään | `"Salasanat eivät täsmää"` |
| TC5 | Puuttuva etunimi hylätään | `"Etunimi on pakollinen"` |
| TC6 | Puuttuva sukunimi hylätään | `"Sukunimi on pakollinen"` |

### HTML-raportit

| Raportti | Linkki |
|---|---|
| RF – Kirjautuminen | [reports/report.html](tests/reports/report.html) |
| RF – Rekisteröinti | [reports/register_report.html](tests/reports/register_report.html) |

---

## Yhteenveto

| | Määrä |
|---|---|
| Tehtäviä (JS yksikkötestit) | 8 |
| JS testejä yhteensä | 32 |
| Robot Framework testejä | 12 |
| Läpäissyt | 32 / 32 |
| Epäonnistuneet | 0 |

> Kaikki testit läpäistiin hyväksytysti.  
> [Avaa JS testit selaimessa](tests/tests_Paavo.html)
