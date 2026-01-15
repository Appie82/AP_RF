# 🤖 Robot Framework Test Automation Portfolio

Dit project bevat een uitgebreide suite aan geautomatiseerde tests, variërend van basis UI-interacties tot complexe full-stack integratieketens. Het is ontworpen met de focus op stabiliteit, herbruikbaarheid en duidelijke rapportage.

---

## 📂 Project Structuur & Scenario's

De tests zijn logisch onderverdeeld in mappen, waarbij de nummering in de bestandsnamen zorgt voor een overzichtelijke executievolgorde in VS Code.

### 📁 01_HerokuApp (Basis & Geavanceerde UI)
*Focus: Web-elementen, synchronisatie en browser-events.*

| Bestand | Scenario's | Kernconcepten |
| :--- | :--- | :--- |
| **01_auth.robot** | 01 - 04 | Login validatie en Happy Path scenario's. |
| **05_dropdown.robot** | 05 | Interactie met HTML `<select>` menu's (Label vs Value). |
| **06_dynamic.robot** | 06 | **Synchronisatie:** Gebruik van `Wait For Elements State` ipv onbetrouwbare sleeps. |
| **07_data_driven.robot** | 07 | **DRY-principe:** Test Templates voor multi-scenario validatie. |
| **08_negative.robot** | 08 | **Detached State:** Bewijzen dat elementen NIET in de DOM staan. |
| **09_alerts.robot** | 09 | **Event Handling:** Afhandelen van JavaScript Alerts en Confirms. |
| **10_multi_window.robot**| 10 | **Context Management:** Schakelen tussen tabbladen via Page IDs. |
| **11_login_dd.robot** | 11 | **External Data:** Inloggen met data uit een `.csv` bestand. |
| **12_http_health.robot** | 12 | **Protocol Check:** Snelle 200 OK verificatie binnen de browser. |



### 📁 02_SauceDemo (E-commerce & Flows)
*Focus: End-to-end flows en sessiebeheer.*

| Bestand | Scenario's | Kernconcepten |
| :--- | :--- | :--- |
| **01_shop_tests.robot** | 21 - 23 | Volledige checkout flow van inlog tot orderbevestiging. |
| **13_session.robot** | 13 | **Hybrid Testing:** Browser-sessie (cookies) injecteren in API-requests. |

### 📁 03_Integratie (Full-Stack Keten)
*Focus: Data persistence en systeemoverstijgende flows.*

| Bestand | Scenario's | Kernconcepten |
| :--- | :--- | :--- |
| **03_api_chaining.robot** | 24 | **Data Chaining:** API -> DateTime transformatie -> SQLite opslag -> UI check. |
| **03_api_chaining.robot** | 25 | **Bulk Processing:** Iteratieve verwerking van unieke datasets via `FOR` loops. |
| **03_api_chaining.robot** | 26 | **Self-Cleaning:** Automatische SQL-retentie (opschonen van oude testdata). |



---

## 🛠️ Over dit Project: Architectuur & Keuzes

In dit framework heb ik bewust gekozen voor een moderne benadering van testautomatisering.

### 🚀 Tech Stack Onderbouwing
* **Robot Framework:** Gekozen vanwege de uitstekende leesbaarheid en krachtige rapportage.
* **Browser Library (Playwright):** Sneller en stabieler dan Selenium door directe communicatie met de browser-engine en ingebouwde auto-waiting.
* **RequestsLibrary:** Voor snelle backend-validatie en het 'seeden' van testdata.
* **SQLite:** Gebruikt als 'Source of Truth' om data-integriteit over de gehele keten te bewijzen.

### 💡 Best Practices
* **Page Object Pattern:** Alle selectors en herbruikbare acties zijn ondergebracht in `common.resource`.
* **Data-Driven Design:** Scheiding van testdata (CSV/DB) en testlogica.
* **Headless Execution:** Geoptimaliseerd voor CI/CD integratie.



---

## 📊 Rapportage & Analyse
Elke testrun genereert een gedetailleerde `log.html`. 
* **Screenshots:** Worden automatisch gemaakt bij elke foutieve stap.
* **Traceability:** Elke stap toont de exacte parameters en server-responses.

---

## 🚀 Installatie & Gebruik
1. Clone deze repository.
2. Installeer dependencies: `pip install -r requirements.txt`.
3. Initialiseer Playwright: `rfbrowser init`.
4. Run de volledige suite: `robot tests/`.