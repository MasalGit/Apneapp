# Apneapp – Testausdokumentti

**Testaaja:** Yamama  
**Päivämäärä:** 26.4.2026  
**Branch:** `Henri_FE`

---

## Tehtävä 1 – isValidEmail() – Sähköpostin validointi

[Katso testit selaimessa](tests/tests_Henri.html)

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

[Katso testit selaimessa](tests/tests_Henri.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 6 merkkiä | `abc123` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 5 merkkiä | `abc12` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 3 – Salasanan validointi (rekisteröinti, min 8 merkkiä)

[Katso testit selaimessa](tests/tests_Henri.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 8 merkkiä | `abc12345` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 7 merkkiä | `abc1234` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 4 – passwordsMatch() – Salasanojen täsmäys (rekisteröinti)

[Katso testit selaimessa](tests/tests_Henri.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Samat salasanat | `abc12345` / `abc12345` | `true` |
| 2 | Erilaiset salasanat | `abc12345` / `xyz99999` | `false` |
| 3 | Molemmat tyhjiä | *(tyhjä)* / *(tyhjä)* | `true` |
| 4 | Iso/pieni kirjain | `Salasana1` / `salasana1` | `false` |

---

## Tehtävä 5 – isEmpty() – Nimen tyhjyystarkistus

[Katso testit selaimessa](tests/tests_Henri.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Tyhjä merkkijono | *(tyhjä)* | `true` |
| 2 | Pelkät välilyönnit | `   ` | `true` |
| 3 | Normaali etunimi | `Henri` | `false` |
| 4 | Numero | `0` | `false` |

---

## Tehtävä 6 – validateLoginForm() – Kirjautumislomakkeen validointi

[Katso testit selaimessa](tests/tests_Henri.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Oikea sähköposti + vahva salasana | `kayttaja@email.fi` / `salasana1` | `true` |
| 2 | Väärä sähköposti | `eiole` / `salasana1` | `false` |
| 3 | Liian lyhyt salasana | `kayttaja@email.fi` / `abc` | `false` |
| 4 | Molemmat väärät | *(tyhjä)* / *(tyhjä)* | `false` |
| 5 | Tyhjä sähköposti | *(tyhjä)* / `salasana1` | `false` |
