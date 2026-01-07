# 🤖 Robot Framework Automation Suite
![Robot Framework Tests](https://github.com/Appie82/AP_RF/actions/workflows/main.yml/badge.svg)

Dit project is een robuust en schaalbaar testautomatisering framework gebouwd met **Robot Framework** en de **Browser (Playwright) Library**. Het framework is ontworpen volgens moderne "best practices", waarbij de focus ligt op onderhoudbaarheid, snelheid en de combinatie van Frontend (UI) en Backend (API) testen.

---

## 🚀 Project Architectuur
Er is gekozen voor een modulaire opbouw om het framework "future-proof" te maken:

* **`common.resource`**: Het centrale zenuwcentrum. Bevat gedeelde instellingen, globale variabelen en herbruikbare keywords (DRY-principe).
* **`.github/workflows/main.yml`**: De CI/CD motor die zorgt dat alle 20 tests automatisch draaien in de cloud bij elke push.
* **`results/`**: Bevat de automatisch gegenereerde rapportages, logs en screenshots.

---

## 📂 Test Portfolio (20 Scenario's)

### 01_basis: Fundamenten & Stabiliteit
| Suite | Omschrijving |
| :--- | :--- |
| **01_auth** | Fundamentele tests voor het inlogproces (Happy Path). |
| **02_navigatie** | Controleert of de hoofdelementen en landingpage correct laden. |
| **03_api** | Backend validatie; communiceert rechtstreeks met endpoints (JSON). |
| **04_hybrid** | Gebruikt API-auth om UI-acties te versnellen. |
| **05_dropdowns** | Interactie met HTML select-menu's en dropdown validatie. |
| **06_dynamic** | Test synchronisatie met AJAX-content (Wait For Elements). |
| **07_data_driven** | Negatieve inlogscenario's via Test Templates. |
| **08_negative** | Validatie van afwezige elementen (Detached state). |
| **09_alerts** | Automatische afhandeling van JavaScript pop-ups en dialogen. |
| **10_multi_window** | Context management tussen verschillende tabbladen. |
| **11_login_dd** | Uitgebreide data-driven login met variabele variabelen. |
| **12_http_health** | Protocol-check (Status 200) binnen actieve browser-sessie. |

### 02_geavanceerd: Expert-level Scenario's
| Suite | Omschrijving |
| :--- | :--- |
| **13_session_inject** | Injecteert direct sessie-cookies om UI-login over te slaan. |
| **14_search** | Functionele test van zoekalgoritmes en resultaat-filters. |
| **15_profile** | Validatie van data-persistentie na wijzigingen en refreshes. |
| **16_api_deep_dive** | Testen van complexe geneste JSON-objecten en headers. |
| **17_visual** | Visual Regression Testing (Screenshot vergelijking). |
| **18_upload** | Test interactie met het OS voor het uploaden van bestanden. |
| **19_shadow_dom** | Doorbreken van isolatielagen in moderne webcomponenten. |
| **20_iframes** | Interactie met geneste frames en externe tekst-editors. |

---

## 🛠️ Lokale Uitvoering
Draai de volledige suite met één klik via de batch-file:
1. Start `draai_alle_tests.bat`.
2. Bekijk het resultaat in de automatisch geopende `log.html`.

---
_Gerealiseerd met Robot Framework, Browser Library & GitHub Actions._