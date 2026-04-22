# Apneapp – Testausdokumentti

## Projektin tiedot
- **Projekti:** Apneapp – kirjautumis- ja rekisteröintisivut
- **Testaaja:** Yamama
- **Päivämäärä:** 22.4.2026

---

## 1. Kirjautumislomake (`index.html`)

### 1.1 Sähköpostin validointi

| Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|---|---|---|
| Oikea sähköposti | `kayttaja@esimerkki.fi` | Hyväksytään | ✅ |
| Tyhjä kenttä | *(tyhjä)* | Virhe: "Sähköposti on pakollinen" | ✅ |
| Puuttuu @-merkki | `kayttajaesimerkki.fi` | Virhe: "Virheellinen sähköpostiosoite" | ✅ |
| Puuttuu piste | `kayttaja@esimerkki` | Virhe: "Virheellinen sähköpostiosoite" | ✅ |
| Välilyönti osoitteessa | `kayttaja @esimerkki.fi` | Virhe: "Virheellinen sähköpostiosoite" | ✅ |

### 1.2 Salasanan validointi

| Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|---|---|---|
| Tyhjä kenttä | *(tyhjä)* | Virhe: "Salasana on pakollinen" | ✅ |
| Alle 6 merkkiä | `abc1` | Virhe: "Salasanan on oltava vähintään 6 merkkiä" | ✅ |
| Täsmälleen 6 merkkiä | `abc123` | Hyväksytään | ✅ |
| Yli 6 merkkiä | `turvallinen123` | Hyväksytään | ✅ |

### 1.3 Salasanan näyttö/piilotus

| Testitapaus | Toiminto | Odotettu tulos | Tulos |
|---|---|---|---|
| Paina silmäikoni | Klikkaus | Salasana näkyy tekstinä | ✅ |
| Paina silmäikoni uudelleen | Klikkaus | Salasana piilotetaan | ✅ |

### 1.4 Muista minut -toiminto

| Testitapaus | Toiminto | Odotettu tulos | Tulos |
|---|---|---|---|
| Rasti ruutuun + kirjaudu | Kirjautuminen | Sähköposti tallentuu localStorageen | ✅ |
| Ei rastia + kirjaudu | Kirjautuminen | Sähköpostia ei tallenneta | ✅ |
| Avaa sivu uudelleen | Sivun lataus | Tallennettu sähköposti täytetään automaattisesti | ✅ |

### 1.5 Kirjautumisen kulku

| Testitapaus | Toiminto | Odotettu tulos | Tulos |
|---|---|---|---|
| Oikeat tiedot | Kirjaudu-nappi | Spinner näkyy → "Kirjautuminen onnistui!" → ohjaus dashboard.html | ✅ |

---

## 2. Rekisteröintilomake (`register.html`)

### 2.1 Kenttien validointi

| Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|---|---|---|
| Tyhjä etunimi | *(tyhjä)* | Virhe näytetään | ✅ |
| Tyhjä sähköposti | *(tyhjä)* | Virhe näytetään | ✅ |
| Väärä sähköpostimuoto | `teksti` | Virhe näytetään | ✅ |
| Salasana alle 8 merkkiä | `abc123` | Virhe näytetään | ✅ |
| Salasanat eivät täsmää | `abc12345` / `xyz99999` | Virhe: "Salasanat eivät täsmää" | ✅ |
| Käyttöehtoja ei hyväksytty | *(rasti puuttuu)* | Virhe näytetään | ✅ |

---

## 3. Unohdettu salasana (`forgot-password.html`)

| Testitapaus | Syöte | Odotettu tulos | Tulos |
|---|---|---|---|
| Tyhjä sähköposti | *(tyhjä)* | Virhe näytetään | ✅ |
| Virheellinen sähköposti | `teksti` | Virhe näytetään | ✅ |
| Oikea sähköposti | `kayttaja@esimerkki.fi` | Vahvistusviesti näytetään | ✅ |

---

## 4. Dashboard (`dashboard.html`)

| Testitapaus | Toiminto | Odotettu tulos | Tulos |
|---|---|---|---|
| Sivun avaus | Lataus | Kaikki kortit ja data näkyvät | ✅ |
| Kirjaudu ulos -nappi | Klikkaus | Ohjaus index.html | ✅ |
| Päivämäärä | Lataus | Tämän päivän päivämäärä näytetään | ✅ |

---

## 5. Yleiset UI-testit

| Testitapaus | Odotettu tulos | Tulos |
|---|---|---|
| Mobiili 375px | Sivut skaalautuvat oikein | ✅ |
| Tabletti 768px | Sivut skaalautuvat oikein | ✅ |
| Työpöytä 1440px | Sivut skaalautuvat oikein | ✅ |
| Chrome-selain | Kaikki toimii | ✅ |
| Firefox-selain | Kaikki toimii | ✅ |

---

## Yhteenveto

| | Määrä |
|---|---|
| Testattu yhteensä | 28 |
| Läpäissyt | 28 |
| Epäonnistuneet | 0 |

> Kaikki testit läpäistiin hyväksytysti. ✅
