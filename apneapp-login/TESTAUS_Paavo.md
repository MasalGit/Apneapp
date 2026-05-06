# Apneapp – Testausdokumentti

**Testaaja:** Yamama  
**Päivämäärä:** 6.5.2026  
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

## Tehtävä 9 – getColor() – LF/HF-arvon värikoodi (graph.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Arvo alle 0.6 (vihreä) | `0.5` | `"#22c55e"` |
| 2 | Raja-arvo 0.6 (keltainen) | `0.6` | `"#facc15"` |
| 3 | Arvo 1.0 (keltainen) | `1.0` | `"#facc15"` |
| 4 | Raja-arvo 1.2 (punainen) | `1.2` | `"#ef4444"` |
| 5 | Arvo yli 1.2 (punainen) | `1.5` | `"#ef4444"` |

---

## Tehtävä 10 – hexToRgb() – HEX → RGB-muunnos (graph.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Vihreä väri | `"#22c55e"` | `"34,197,94"` |
| 2 | Punainen väri | `"#ef4444"` | `"239,68,68"` |
| 3 | Keltainen väri | `"#facc15"` | `"250,204,21"` |

---

## Tehtävä 11 – processData() v2 – Päivitetty datan suodatus (graph.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

Uusi versio käyttää yhdistettyä dataa `{date, hours, lfhf}` ja suodattaa cutoff-päivämäärän mukaan (korvasi vanhan hours+quality-version).

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Tämän päivän data, days=7 | `[{date: tänään, hours:8, lfhf:0.5}]` | `sleep:[8]`, `lfhf:[0.5]` |
| 2 | Tyhjä taulukko | `[]`, days: `7` | `{labels:[], sleep:[], lfhf:[]}` |
| 3 | Vanha data (100 pv sitten), days=7 | `[{date: 100 pv sitten, hours:7, lfhf:1.0}]` | `sleep:[]` (suodatettu pois) |

---

## Tehtävä 12 – Manuaalinen testi: Graph-sivun uudet ominaisuudet

| # | Testitapaus | Toiminto | Odotettu tulos |
|---|---|---|---|
| 1 | LF/HF-viiva näkyy kaaviossa | Avaa graph.html → katso kaavio | Y-akseli 2 näyttää "LF/HF Avg" eikä "Riskiarvio" |
| 2 | 365 pv -painike toimii | Klikkaa "365 pv" -painiketta | Kaavio lataa 365 päivän datan |
| 3 | fetchMeasurements hakee oikein | Kirjaudu sisään, avaa graph.html | Pyyntö menee `/api/measurements?days=7` |
| 4 | Riskiarvio-riviä ei enää näytetä | Avaa graph.html | `calculateRiskFromQuality` poistettu – ei risk-dataa kaaviossa |

---

## Tehtävä 13 – interpret() – Riskitason tulkinta (report.html)

[Katso testit selaimessa](tests/tests_Paavo.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Korkea riski (elevatedRatio > 0.5) | `{elevatedRatio: 0.8, avgSleep: 5, avgLFHF: 0.7}` | riskLevel: `"Korkea"`, msg sisältää "stressi" ja "terveydenhuolto" |
| 2 | Keskitaso (elevatedRatio 0.2–0.5) | `{elevatedRatio: 0.3, avgSleep: 7, avgLFHF: 0.4}` | riskLevel: `"Keskitaso"` |
| 3 | Matala riski (elevatedRatio < 0.2) | `{elevatedRatio: 0.1, avgSleep: 8, avgLFHF: 0.3}` | riskLevel: `"Matala"`, msg sisältää "hyvällä tasolla" |
| 4 | Liian vähän unta (avgSleep < 6) | `{elevatedRatio: 0.0, avgSleep: 5, avgLFHF: 0.2}` | msg sisältää "alle suosituksen" |

---

## Tehtävä 14 – Manuaalinen testi: Raportti-sivu (report.html)

| # | Testitapaus | Toiminto | Odotettu tulos |
|---|---|---|---|
| 1 | Sivu latautuu oikein | Avaa report.html kirjautuneena | Näytetään kortit: Keskiarvoinen uni, LF/HF keskiarvo, Mittauksia |
| 2 | Riskitaso näkyy | Avaa report.html | `#riskLevel`-elementti täytetään: Matala / Keskitaso / Korkea |
| 3 | Navigointi toimii | Klikkaa sivupalkin linkkejä | Siirrytään oikein dashboard / graph / report sivuille |
| 4 | API-virhe käsitellään | Käytä ilman tokenia | Teksti "Raportin lataus epäonnistui." näkyy |

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
| Tehtäviä (JS yksikkötestit) | 12 |
| Manuaalisia tehtäviä | 2 |
| JS testejä yhteensä | 47 |
| Robot Framework testejä | 12 |
| Läpäissyt | 47 / 47 |
| Epäonnistuneet | 0 |

> Kaikki testit läpäistiin hyväksytysti.  
> [Avaa JS testit selaimessa](tests/tests_Paavo.html)
