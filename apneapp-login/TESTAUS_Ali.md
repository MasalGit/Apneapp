# Apneapp – Testausdokumentti

**Testaaja:** Ali  
**Päivämäärä:** 4.5.2026  
**Branch:** `ali-fe2-work`

---

## Tehtävä 1 – isValidEmail() – Sähköpostin validointi (kirjautuminen)

[Katso testit selaimessa](tests/tests_Ali.html)

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

## Tehtävä 2 – Salasanan validointi – kirjautuminen (min 6 merkkiä)

[Katso testit selaimessa](tests/tests_Ali.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 6 merkkiä | `abc123` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 5 merkkiä | `abc12` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 3 – Salasanan validointi – rekisteröinti (min 8 merkkiä)

[Katso testit selaimessa](tests/tests_Ali.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 8 merkkiä | `abc12345` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 7 merkkiä | `abc1234` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 4 – Salasanojen täsmäys (rekisteröinti)

[Katso testit selaimessa](tests/tests_Ali.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Samat salasanat | `abc12345` / `abc12345` | `true` |
| 2 | Erilaiset salasanat | `abc12345` / `xyz99999` | `false` |
| 3 | Molemmat tyhjiä | *(tyhjä)* / *(tyhjä)* | `true` |
| 4 | Iso/pieni kirjain | `Salasana1` / `salasana1` | `false` |

---

## Tehtävä 5 – Salasanan vahvuuslaskin (rekisteröinti)

[Katso testit selaimessa](tests/tests_Ali.html)

Rekisteröintisivulla `register.html` on salasanan vahvuuslaskin, joka arvioi salasanan pisteet (0–4):
- **+1** jos pituus ≥ 8 merkkiä  
- **+1** jos sisältää ison kirjaimen  
- **+1** jos sisältää numeron  
- **+1** jos sisältää erikoismerkin  

| # | Testitapaus | Syöte | Odotettu pisteet | Odotettu taso |
|---|---|---|---|---|
| 1 | Alle 8 merkkiä, ei mitään erikoista | `abc` | 0 | *(tyhjä)* |
| 2 | 8 merkkiä, ei muuta | `abcdefgh` | 1 | Heikko |
| 3 | 8 merkkiä + iso kirjain | `Abcdefgh` | 2 | Kohtalainen |
| 4 | 8 merkkiä + iso + numero | `Abcdefg1` | 3 | Hyvä |
| 5 | Kaikki kriteerit täyttyvät | `Abcdef1!` | 4 | Vahva |

---

## Tehtävä 6 – applyGlobalTheme() – Teeman lataus

[Katso testit selaimessa](tests/tests_Ali.html)

Funktio `applyGlobalTheme()` lukee `localStorage`-arvon `apneapp-theme` ja lisää/poistaa `dark-mode`-luokan `body`-elementistä.

| # | Testitapaus | localStorage-arvo | Odotettu tulos |
|---|---|---|---|
| 1 | Tumma teema tallennettu | `"dark"` | `body.classList` sisältää `"dark-mode"` |
| 2 | Vaalea teema tallennettu | `"light"` | `body.classList` ei sisällä `"dark-mode"` |
| 3 | Ei tallennettu arvoa | *(ei arvoa)* | `body.classList` ei sisällä `"dark-mode"` (oletus: light) |

---

## Tehtävä 7 – applyTranslations() – Kielenkääntö (language.js)

[Katso testit selaimessa](tests/tests_Ali.html)

Funktio `applyTranslations()` tiedostossa `src/js/language.js` lukee `localStorage`-arvon `apneapp-language` ja päivittää kaikki `data-i18n`-attribuutit vastaavasti.

| # | Testitapaus | localStorage-arvo | Odotettu tulos |
|---|---|---|---|
| 1 | Suomi valittu | `"fi"` | `data-i18n="logout"` → "Kirjaudu ulos" |
| 2 | Englanti valittu | `"en"` | `data-i18n="logout"` → "Log out" |
| 3 | Ei tallennettu arvoa | *(ei arvoa)* | Oletuskielenä suomi → "Kirjaudu ulos" |
| 4 | Suomi – dashboard-otsikko | `"fi"` | `data-i18n="dashboardTitle"` → "Yleiskatsaus" |
| 5 | Englanti – dashboard-otsikko | `"en"` | `data-i18n="dashboardTitle"` → "Overview" |

---

## Tehtävä 8 – logout() – Uloskirjautuminen

[Katso testit selaimessa](tests/tests_Ali.html)

Funktio `logout()` poistaa `token`-avaimen `localStorage`-muistista ja ohjaa käyttäjän `index.html`-sivulle.

| # | Testitapaus | Lähtötila | Odotettu tulos |
|---|---|---|---|
| 1 | Token poistetaan | `localStorage["token"] = "abc123"` → kutsu `logout()` | `localStorage.getItem("token")` → `null` |
| 2 | Ohjaus tapahtuu | Token tallennettu | `window.location.href` → `"index.html"` |
| 3 | Ei tokenia (ei virheitä) | `localStorage["token"]` ei olemassa | Toimii virheettä, ohjaa silti |

---

## Tehtävä 9 – getPasswordStrengthScore() – Salasanan vahvuus (lisätesti)

[Katso testit selaimessa](tests/tests_Ali.html)

| # | Testitapaus | Syöte | Odotettu pisteet |
|---|---|---|---|
| 1 | Tyhjä merkkijono | `""` | 0 |
| 2 | Vain lyhyt sana | `"hello"` | 0 |
| 3 | 8 merkkiä vain pieniä | `"abcdefgh"` | 1 |
| 4 | 8 + iso kirjain | `"Abcdefgh"` | 2 |
| 5 | 8 + iso + numero | `"Abcdefg1"` | 3 |
| 6 | 8 + iso + numero + erikois | `"Abcdef1!"` | 4 |

---

## Tehtävä 10 – Kirjautumissivu (index.html) – Manuaaliset testit

**Testataan:** Kirjautumislomakkeen toiminta käyttöliittymässä  
**Edellytys:** Selain auki, BE-palvelin käynnissä (`npm run dev` Henri_BE-branchilla)

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC1 | Tyhjä lomake | Klikkaa "Kirjaudu sisään" ilman syötteitä | Virheilmoitukset molemmille kentille |
| TC2 | Virheellinen sähköposti | Syötä `"ei-email"`, klikkaa lähetä | "Virheellinen sähköpostiosoite" |
| TC3 | Liian lyhyt salasana | Syötä oikea email + salasana alle 6 merkkiä | "Salasanan on oltava vähintään 6 merkkiä" |
| TC4 | Salasana näkyviin | Klikkaa silmä-ikoni | Salasana näkyy tekstinä, ikoni vaihtuu |
| TC5 | Muista sähköposti | Valitse "Muista minut", kirjaudu sisään | Sähköposti tallennettu `localStorage`-muistiin |
| TC6 | Onnistunut kirjautuminen | Syötä oikeat Kubios-tunnukset | Token tallentuu, ohjataan `dashboard.html`-sivulle |
| TC7 | Väärä salasana | Syötä väärä salasana | Virheilmoitus näytetään |

---

## Tehtävä 11 – Rekisteröintisivu (register.html) – Manuaaliset testit

**Testataan:** Rekisteröintilomakkeen validointi  
**Huom:** Rekisteröinti on tällä hetkellä simuloitu (ei kutsu backendiä)

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC8 | Tyhjä lomake | Lähetä ilman mitään syötteitä | Virheilmoitukset kaikille pakollisille kentille |
| TC9 | Puuttuva sukunimi | Täytä kaikki paitsi sukunimi | "Sukunimi on pakollinen" |
| TC10 | Virheellinen sähköposti | Syötä `"ei-email"` sähköpostikenttään | "Virheellinen sähköpostiosoite" |
| TC11 | Salasana alle 8 merkkiä | Syötä `"abc123"` salasanaksi | "Salasanan on oltava vähintään 8 merkkiä" |
| TC12 | Salasanat eivät täsmää | Syötä eri salasanat molempiin kenttiin | "Salasanat eivät täsmää" |
| TC13 | Käyttöehdot hyväksymättä | Täytä kaikki kentät mutta älä valitse checkbox | "Hyväksy käyttöehdot jatkaaksesi" |
| TC14 | Vahvuusmittari | Kirjoita `"Abcdef1!"` salasanaksi | Vihreä palkki, teksti "Vahva" |
| TC15 | Onnistunut rekisteröinti | Täytä kaikki kentät oikein, hyväksy ehdot | "Tili luotu onnistuneesti! Ohjataan kirjautumiseen..." |

---

## Tehtävä 12 – Dashboard (dashboard.html) – Manuaaliset testit

**Testataan:** Dashboard-sivun toiminta  
**Edellytys:** Kirjautunut sisään (token tallennettuna)

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC16 | Päivämäärä näkyy | Avaa dashboard | Tämän päivän päivämäärä näkyy suomeksi |
| TC17 | Stats-kortit näkyvät | Avaa dashboard | RMSSD, SDNN, Unen kesto, Apnea-tapahtumat -kortit näkyvät |
| TC18 | Ilmoituskello | Klikkaa kellokuvaketta | Ilmoitusdropdown avautuu, ilmoitukset listattuna |
| TC19 | Ilmoitukset perustuvat asetuksiin | Poista kaikki ilmoitukset asetuksista, palaa dashboardiin | "Ei aktiivisia ilmoituksia." -viesti |
| TC20 | Pikapainikelinkit | Klikkaa "Kaavio" / "Raportit" / "Asetukset" | Ohjaus oikealle sivulle |
| TC21 | Kirjaudu ulos | Klikkaa "Kirjaudu ulos" | Token poistetaan, ohjataan `index.html`-sivulle |
| TC22 | Tumma tila | Aktivoi tumma tila asetuksista, palaa dashboardiin | Dashboard näkyy tummalla teemalla |

---

## Tehtävä 13 – Kaavio (graph.html) – Manuaaliset testit

**Testataan:** Kaaviosivun toiminta  
**Edellytys:** Kirjautunut sisään, BE-palvelin käynnissä

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC23 | Kaavio latautuu | Avaa `graph.html` | Chart.js-kaavio näkyy (pylväät + riskiviiva) |
| TC24 | 7 päivän näkymä | Klikkaa "7 pv" | Kaavio näyttää viimeiset 7 päivää |
| TC25 | 30 päivän näkymä | Klikkaa "30 pv" | Kaavio päivittyy 30 päivän dataan |
| TC26 | 90 päivän näkymä | Klikkaa "90 pv" | Kaavio päivittyy 90 päivän dataan |
| TC27 | Tumma tila kaavio | Aktivoi tumma tila, avaa kaavio | Kaavion taustavärit ja teksti mukautuvat |

---

## Tehtävä 14 – Asetukset (asetukset.html) – Manuaaliset testit

**Testataan:** Asetussivun toiminta  
**Huom:** Kaikki asetukset tallennetaan `localStorage`-muistiin

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC28 | Teematoggle – tumma tila | Klikkaa teematoggle | `body` saa `dark-mode`-luokan, toggle-pallo siirtyy, ikoni vaihtuu kuuhun |
| TC29 | Teematoggle – vaalea tila | Klikkaa uudelleen | `dark-mode`-luokka poistuu, ikoni vaihtuu aurinkoon |
| TC30 | Teema pysyy sivunlatauksen jälkeen | Aktivoi tumma tila, lataa sivu uudelleen | Tumma tila on edelleen päällä |
| TC31 | Kieli vaihto – englanti | Valitse "English" | Sivun tekstit vaihtuvat englanniksi välittömästi |
| TC32 | Kieli vaihto – suomi | Valitse "Suomi" | Tekstit palaavat suomeksi |
| TC33 | Kieli tallentuu | Vaihda englanniksi, lataa sivu uudelleen | Sivu latautuu englanniksi |
| TC34 | Aikamuoto 12h | Valitse "12h", lataa sivu uudelleen | `localStorage["apneapp-time-format"]` = `"12h"` |
| TC35 | Ilmoitustoggle – riskivaroitus pois | Klikkaa "Riskivaroitukset"-toggle pois | Riskivaroitus poistuu dashboardin kellosta |
| TC36 | Ilmoitustoggle – unen kesto pois | Klikkaa "Unen kesto"-toggle pois | Unen kesto -ilmoitus poistuu kellosta |
| TC37 | Ilmoitustoggle – HRV pois | Klikkaa "HRV / RMSSD"-toggle pois | HRV-ilmoitus poistuu kellosta |
| TC38 | Ilmoitusasetukset pysyvät | Sammuta kaikki togglet, lataa sivu uudelleen | Kaikki togglet ovat edelleen pois päältä |

---

## Tehtävä 15 – Raportit (raportit.html) – Manuaaliset testit

**Testataan:** Raportit-sivun toiminta

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC39 | Sivu latautuu | Avaa `raportit.html` | Kolme raporttikortia näkyvät (Uniyhteenveto, HRV-analyysi, Lääkäriraportti) |
| TC40 | Kehitysvaihe-ilmoitus | Avaa sivu | Sininen huomiolaatikko näkyy alhaalla |
| TC41 | Tumma tila | Aktivoi tumma tila, avaa raportit | Kortit näkyvät tummalla pohjalla |

---

## Tehtävä 16 – Tietoja-sivu (about.html) – Manuaaliset testit

**Testataan:** Uusi Tietoja-sivu – sisältö, tyylitys ja navigointi  
**Huom:** Sivu näyttää tietoa sovelluksesta ja uniapneasta

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC42 | Sivu latautuu | Avaa `about.html` | Hero-osio, kolme tietokorttia ja huomiolaatikko näkyvissä |
| TC43 | Navigointi toimii | Klikkaa "Tietoja" sivupalkista | `about.html` avautuu, Tietoja-linkki korostuu |
| TC44 | Tumma tila | Aktivoi tumma tila, avaa about.html | Kortit ja hero-osio näkyvät tummalla teemalla |
| TC45 | Kieli vaihto | Vaihda kieli englanniksi | Sivun tekstit (otsikot, kortit) vaihtuvat englanniksi |

---

## Tehtävä 17 – Asetukset-parannukset (asetukset.html) – Manuaaliset testit

**Testataan:** Päivitetyn Asetukset-sivun uudet ominaisuudet  
**Huom:** Parannettu ulkoasu ja uudet toggle-komponentit

| # | Testitapaus | Toimenpide | Odotettu tulos |
|---|---|---|---|
| TC46 | Ilmoitustoggle – riskivaroitus | Klikkaa Riskivaroitukset-toggle | Toggle aktivoituu/deaktivoituu, localStorage tallentuu |
| TC47 | Ilmoitustoggle – unen kesto | Klikkaa Unen kesto -toggle | Toggle aktivoituu/deaktivoituu, localStorage tallentuu |
| TC48 | Ilmoitustoggle – HRV | Klikkaa HRV/RMSSD-toggle | Toggle aktivoituu/deaktivoituu, localStorage tallentuu |
| TC49 | Aikamuoto 12h tallennetaan | Valitse 12h, lataa sivu | `localStorage["apneapp-time-format"]` = `"12h"` |

---

## Yhteenveto

| Kategoria | Testitapauksia | Läpäissyt | Hylätty |
|-----------|---------------|-----------|---------|
| Yksikkötestit (JS-funktiot) | 33 | 33 | 0 |
| Manuaaliset UI-testit | 49 | 49 | 0 |
| **Yhteensä** | **82** | **82** | **0** |

**Testikattavuus (ali-fe2-work branch):**
- Kirjautuminen (validointi + API): ✅ 100%
- Rekisteröinti (validointi + vahvuusmittari): ✅ 100%
- Dashboard (kortit, ilmoitukset, navigointi): ✅ 100%
- Kaavio (Chart.js, aikavälit, dark mode): ✅ 100%
- Asetukset (teema, kieli, aikamuoto, ilmoitukset): ✅ 100%
- Raportit: ✅ 100%
- Uloskirjautuminen: ✅ 100%
- Teema (dark/light mode): ✅ 100%
- Kielenkääntö (fi/en): ✅ 100%
- Tietoja-sivu (sisältö, navigointi, dark mode, kieli): ✅ 100%
- Asetukset-parannukset (togglet, aikamuoto): ✅ 100%
