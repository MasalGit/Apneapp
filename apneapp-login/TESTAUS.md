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

## Tehtävä 7 – getApneaRiskLevel() – Apnea-riskin taso (dashboard)

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | 0 tapahtumaa/h | `0` | `"Normaali"` |
| 2 | 4 tapahtumaa/h | `4` | `"Normaali"` |
| 3 | 5 tapahtumaa/h | `5` | `"Lievä"` |
| 4 | 12 tapahtumaa/h | `12` | `"Lievä"` |
| 5 | 15 tapahtumaa/h | `15` | `"Kohtalainen"` |
| 6 | 30 tapahtumaa/h | `30` | `"Vaikea"` |

---

## Tehtävä 8 – getSleepPhasePercent() – Univaiheen prosentti (dashboard)

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | 108min / 382min | `108, 382` | `28` |
| 2 | 72min / 382min | `72, 382` | `19` |
| 3 | 0 minuuttia | `0, 382` | `0` |
| 4 | Kokonaisaika 0 | `60, 0` | `0` |
| 5 | Sama arvo | `60, 60` | `100` |

---

## Tehtävä 9 – formatSleepDuration() – Unen keston muotoilu (dashboard)

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | 382 minuuttia | `382` | `"6h 22min"` |
| 2 | 60 minuuttia | `60` | `"1h 0min"` |
| 3 | 90 minuuttia | `90` | `"1h 30min"` |
| 4 | 0 minuuttia | `0` | `"0h 0min"` |

---

## Tehtävä 10 – validateLoginForm() – Kirjautumislomakkeen validointi

[Katso testit selaimessa](tests/tests.html)

| # | Testitapaus | Syöte | Odotettu tulos |
|---|---|---|---|
| 1 | Oikea email + vahva salasana | `kayttaja@email.fi / salasana1` | `true` |
| 2 | Väärä sähköposti | `eiole / salasana1` | `false` |
| 3 | Liian lyhyt salasana | `kayttaja@email.fi / abc` | `false` |
| 4 | Molemmat väärät | *(tyhjät)* | `false` |
| 5 | Tyhjä sähköposti | `"" / salasana1` | `false` |

---

## Yhteenveto

| | Määrä |
|---|---|
| Tehtäviä | 10 |
| Testejä yhteensä | 48 |
| Läpäissyt | 48 |
| Epäonnistuneet | 0 |

> Kaikki testit läpäistiin hyväksytysti.  
> [Avaa testit selaimessa](tests/tests.html)
