# 🤖 Robot Framework Automation Suite
![Robot Framework CI](https://github.com/Appie82/AP_RF/actions/workflows/main.yml/badge.svg)
[![View Test Report](https://img.shields.io/badge/View-Test%20Report-green)](https://appie82.github.io/AP_RF/log.html)

Dit project bevat automatische UI, API en Database tests voor SauceDemo, HerokuApp en JSONPlaceholder.

Dit project is een robuust en schaalbaar testautomatisering framework gebouwd met **Robot Framework**. Het framework combineert de kracht van de **Browser (Playwright)** library met **DatabaseLibrary** en **RequestsLibrary** voor volledige end-to-end validatie.

---

## 🚀 Project Architectuur
Er is gekozen voor een modulaire opbouw:

* **`common.resource`**: Het centrale zenuwcentrum met gedeelde instellingen en DRY-keywords.
* **`keten_test.db`**: Lokale SQLite database voor het valideren van data-persistentie.
* **`.github/workflows/main.yml`**: De CI/CD motor voor automatische cloud-executie.

---

## 📂 Test Portfolio
est Portfolio
01_basis: Fundamenten & Stabiliteit
In deze laag leggen we de basis voor een betrouwbare testsuite. De focus ligt hier op de kritieke paden van de applicatie en technische stabiliteit.

01_auth (Authentication)
Focus: Happy Path inlogproces.

Techniek: SeleniumLibrary / Browser. Valideert of legitieme gebruikers toegang krijgen.

Belang: De "poortwachter" van de applicatie; als dit faalt, werkt de rest ook niet.

02_navigatie (Navigation)
Focus: Structuur en landingpage validatie.

Techniek: URL checks en element verificatie. Controleert of alle menu-items naar de juiste pagina's leiden.

03_api (REST API Validation)
Focus: Backend integriteit.

Techniek: RequestsLibrary. Directe communicatie met endpoints om JSON-responses en HTTP-statuscodes (200, 201) te valideren.

04_hybrid (Hybrid Testing)
Focus: Snelheid en efficiëntie.

Techniek: Combineert API-calls voor data-setup met UI-verificatie. Versnelt testruns door UI-login stappen over te slaan.

05_dropdowns (Select Menus)
Focus: Interactie met complexe UI-elementen.

Techniek: Selectie op basis van labels, waarden en indexen. Cruciaal voor formulieren.

06_dynamic (AJAX & Timing)
Focus: Synchronisatie en stabiliteit.

Techniek: Wait Until... keywords. Voorkomt "flaky tests" door dynamisch te wachten op asynchrone content in plaats van statische pauzes.

07_data_driven (Negative Testing)
Focus: Dekking van foutscenario's.

Techniek: Test Templates. Eén testscript wordt uitgevoerd met meerdere datasets om robuustheid te garanderen.

08_negative (Error Handling)
Focus: Gebruikerservaring bij fouten.

Techniek: Validatie van foutmeldingen en het controleren van de afwezigheid van elementen (Element Should Not Be Visible).

09_alerts (JavaScript Dialogs)
Focus: Browser-interactie.

Techniek: Handle Alert. Automatiseert de afhandeling van pop-ups, confirmaties en prompts.

10_multi_window (Context Management)
Focus: Workflow continuïteit.

Techniek: Switch Window/Page. Test scenario's waarbij acties in een nieuw tabblad of venster plaatsvinden.

11_login_dd (Advanced Data Driven)
Focus: Uitgebreide variabelen tests.

Techniek: Gebruik van complexe data-sets om de grenzen van het authenticatie-systeem op te zoeken.

12_http_health (Protocol Checks)
Focus: Netwerk integriteit.

Techniek: Statuscode checks op actieve pagina's. Detecteert gebroken links (404) of serverfouten (500) tijdens de UI-sessie.



### 02_geavanceerd: Expert-level Scenario's
📂 02_geavanceerd: Expert-level Scenario's
In deze sectie pakken we de "lastige" onderdelen van moderne webapplicaties aan, zoals beveiliging, complexe datastructuren en geïsoleerde componenten.

13_shopping_cart (Session Inject)
Focus: E-commerce workflow optimalisatie.

Techniek: Het direct injecteren van cookies of sessie-data om het inlogproces over te slaan en direct bij het winkelmandje te beginnen.

Belang: Bespaart tijd in grote testsuites door niet telkens de UI-login te doorlopen.

14_product_search (Search Algorithms)
Focus: Functionele validatie van zoekfuncties.

Techniek: Gebruik van filters en sorteer-logica om te verifiëren of de juiste zoekresultaten bovenaan verschijnen.

Belang: Essentieel voor conversie in webshops.

15_user_profile (Data Persistence)
Focus: Gebruikersdata integriteit.

Techniek: Het wijzigen van profielinstellingen en controleren of deze na een browser-refresh of database-check nog steeds correct zijn.

16_api_complex (Deep Dive API)
Focus: Geavanceerde data-validatie.

Techniek: Testen van geneste JSON-objecten en lijsten binnen API-responses. Controleert niet alleen de statuscode, maar de diepe inhoud van de data.

17_visual_regression (Screenshot Comparison)
Focus: Visuele perfectie.

Techniek: Het maken van een 'base-line' screenshot en deze bij elke run vergelijken met de huidige staat om pixel-afwijkingen te vinden.

Belang: Vindt fouten in de styling (CSS) die een normale functionele test niet ziet.

18_file_upload (OS Interaction)
Focus: Upload-functionaliteit.

Techniek: Interactie met het besturingssysteem om bestanden te selecteren en te uploaden naar de webserver.

Belang: Kritiek voor applicaties waarbij documentbeheer centraal staat.

19_shadow_dom (Shadow Root Access)
Focus: Moderne webcomponenten.

Techniek: Het doorbreken van de isolatielaag van de Shadow DOM. Standaard selectors werken hier vaak niet, dus gebruiken we speciale Playwright/Selenium paden.

20_iframes (Nested Frames)
Focus: Frame switching.

Techniek: Focus verleggen van de hoofd-pagina naar een <iframe> (bijvoorbeeld een externe editor of advertentie) en weer terug.



📁 03_Integratie (Full-Stack Keten) 🆕
Hier combineren we alle technieken: API, Database en UI.

03_api_chaining.robot	24	Data Persistence: Haalt API data, transformeert deze via DateTime, slaat op in SQLite en verifieert via de UI.

03_api_chaining.robot	25	Bulk Processing: Gebruikt een FOR loop om 10 unieke gebruikers iteratief te verwerken.

03_api_chaining.robot	26	Self-Cleaning: Automatische SQL-retentie die data ouder dan 24 uur verwijdert bij de start van de suite.
---

## 🛠️ Lokale Uitvoering & Vereisten
Draai de volledige suite via de batch-file of individuele files:
1. Zorg voor de benodigde libraries: `pip install robotframework-requests robotframework-databaselibrary robotframework-seleniumlibrary`
2. Start `draai_alle_tests.bat`.
3. De database (`.db`) wordt automatisch geïnitialiseerd bij de eerste run.

---
_Gerealiseerd met Robot Framework, Browser Library, SQLite & GitHub Actions._