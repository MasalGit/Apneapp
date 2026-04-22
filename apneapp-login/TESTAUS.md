# Apneapp – Testausdokumentti

**Testaaja:** Yamama  
**Päivämäärä:** 22.4.2026  
**Branch:** `Yamama-FE`

---

## Tehtävä 1 – isValidEmail() – Sähköpostin validointi

[Katso testit selaimessa](tests/tests.html)

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

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 6 merkkiä | `abc123` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 5 merkkiä | `abc12` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 3 – Salasanan validointi (rekisteröinti, min 8 merkkiä)

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Täsmälleen 8 merkkiä | `abc12345` | `true` |
| 2 | Pitkä salasana | `turvallinen123!` | `true` |
| 3 | 7 merkkiä | `abc1234` | `false` |
| 4 | Tyhjä | *(tyhjä)* | `false` |

---

## Tehtävä 4 – passwordsMatch() – Salasanojen täsmäys

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Samat salasanat | `abc12345` / `abc12345` | `true` |
| 2 | Erilaiset salasanat | `abc12345` / `xyz99999` | `false` |
| 3 | Molemmat tyhjiä | *(tyhjä)* / *(tyhjä)* | `true` |
| 4 | Iso/pieni kirjain | `Salasana1` / `salasana1` | `false` |

---

## Tehtävä 5 – isEmpty() – Tyhjyystarkistus

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Tyhjä merkkijono | ```  | `true` |
| 2 | Pelkät välilyönnit | `   ` | `true` |
| 3 | Normaali teksti | `Yamama` | `false` |
| 4 | Numero | `0` | `false` |

---

## Tehtävä 6 – isValidName() – Nimen validointi

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Normaali nimi | `Yamama` | `true` |
| 2 | Tyhjä nimi | *(tyhjä)* | `false` |
| 3 | Pelkät välilyönnit | `   ` | `false` |
| 4 | 50 merkin nimi | `aaa...` (50) | `true` |
| 5 | 51 merkin nimi | `aaa...` (51) | `false` |

---

## Yhteenveto

| | Määrä |
|---|---|
| Tehtäviä | 6 |
| Testejä yhteensä | 24 |
| Läpäissyt | 24 |
| Epäonnistuneet | 0 |

> Kaikki testit läpäistiin hyväksytysti.  
> [Avaa testit selaimessa](tests/tests.html)
