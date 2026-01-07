Robot Framework Automation Suite
Dit project is een robuust en schaalbaar testautomatisering framework gebouwd met Robot Framework. Het framework is ontworpen volgens moderne "best practices", waarbij de focus ligt op onderhoudbaarheid, snelheid en de combinatie van Frontend (UI) en Backend (API) testen.

🚀 Project Architectuur
Er is gekozen voor een modulaire opbouw om het framework "future-proof" te maken:

common.resource: Het centrale zenuwcentrum. Bevat gedeelde instellingen, globale variabelen (URL's, credentials) en herbruikbare keywords.

.github/workflows/main.yml: De CI/CD motor die zorgt dat tests automatisch in de cloud draaien (Headless) bij elke push naar GitHub.

results/: Automatisch gegenereerde rapportages, logs en screenshots bij fouten.

📂 Testscenario's: 01_basis
Focus op kernfunctionaliteit en betrouwbaarheid.

01_auth.robot: Fundamentele tests voor de "Happy Path" login.

02_navigatie.robot: Verifieert of de hoofdelementen van de website correct laden.

03_api.robot: Pure backend validatie via JSON-responses.

04_hybrid.robot: Combineert API-logins met UI-acties voor maximale snelheid.

05_dropdowns.robot: Test interactie met select-menu's en keuzelijsten.

06_dynamic_loading.robot: Test synchronisatie met AJAX-content via Wait For Elements State.

07_data_driven.robot: Gebruikt templates voor bulk-validatie van negatieve inlogpogingen.

08_negative_check.robot: Bewijst de afwezigheid van elementen via de detached state.

09_js_alerts.robot: Handelt browser-native pop-ups en JavaScript-bevestigingen af.

10_multi_window.robot: Beheert unieke Page ID's om te wisselen tussen tabbladen.

11_login_datadriven.robot: Geavanceerde data-driven tests met variabele verwachte uitkomsten.

12_http_health.robot: Directe protocol-validatie (Status 200 OK) binnen de browsercontext.

📂 Testscenario's: 02_geavanceerd
Focus op complexe webtechnieken en expert-level automatisering.

13_session_injection.robot: Omzeilt de login-UI door direct cookies in de context te injecteren.

14_product_search.robot: Valideert zoekalgoritmes en "geen resultaten" scenario's.

15_profile_management.robot: Test data-persistentie na pagina-refreshes.

16_api_complex.robot: Diepe duik in geneste JSON-data en headers.

17_visual_regression.robot: Vergelijkt screenshots met een "Golden Master" voor layout-validatie.

18_file_upload.robot: Simuleert interactie met het bestandssysteem voor uploads.

19_shadow_dom.robot: Pikt door isolatielagen van moderne webcomponenten heen.

20_iframes.robot: Schakelt context naar geneste iFrames voor interactie met externe editors.

🛠️ Gebruik
Om de volledige suite lokaal te draaien en direct het rapport in de browser te openen, gebruik je het meegeleverde batch-bestand:

Dubbelklik op draai_alle_tests.bat.

De tests draaien (Headed modus).

Na afloop opent log.html automatisch voor analyse.




Negative Testing (08): Bevestigt dat foutmeldingen correct worden afgehandeld zonder de pipeline te breken.

keywords.resource.txt: Verzameling van project-specifieke keywords voor betere leesbaarheid.

⚙️ Configuratie & Scripts
env_test.py / env_acc.py: Python-configuraties voor verschillende testomgevingen.

run_tests.bat / draai_test.bat: Snelkoppelingen om lokaal de juiste testset te starten.

requirements.txt: Bevat alle dependencies voor een snelle installatie.

🛠️ Testmethodieken
In dit framework worden drie verschillende teststrategieën toegepast:

UI Testing (Frontend): Gebruik van de Browser library (Playwright) voor stabiele browser-interactie. Dankzij de auto-waiting functionaliteit zijn deze tests minder foutgevoelig.

API Testing (Backend): Directe communicatie met de server via de RequestsLibrary. Dit biedt razendsnelle validatie van de bedrijfslogica.

Hybrid Testing: Inloggen via een API-call, waarna het sessie-cookie wordt geïnjecteerd in de browser. Dit bespaart tijd door trage UI-loginpaden over te slaan.

📈 Waarom deze opzet?
Onderhoudbaarheid: Centrale variabelen in .resource bestanden maken beheer eenvoudig.

Stabiliteit: Geen onbetrouwbare Sleep commando's, maar intelligente wachtmechanismes.

Foutanalyse: Automatische screenshots in de Test Teardown versnellen de "Root Cause Analysis".

💻 Installatie & Gebruik
Vereisten
Python 3.x

Robot Framework

Browser Library (Playwright)

Requests Library

![Robot Framework Tests](https://github.com/Appie82/AP_RF/actions/workflows/main.yml/badge.svg)