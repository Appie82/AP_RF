Robot Framework Automation Suite
Dit project is een robuust en schaalbaar testautomatisering framework gebouwd met Robot Framework. Het framework is ontworpen volgens moderne "best practices", waarbij de focus ligt op onderhoudbaarheid, snelheid en de combinatie van Frontend (UI) en Backend (API) testen.

🚀 Project Architectuur
Er is gekozen voor een modulaire opbouw om het framework "future-proof" te maken:

common.resource: Het centrale zenuwcentrum. Bevat gedeelde instellingen, globale variabelen (URL's, credentials) en herbruikbare keywords. Dit voorkomt dubbele code (DRY-principe).

.github/workflows/main.yml: De CI/CD motor die zorgt dat tests automatisch draaien bij elke push naar GitHub.

results/: Automatisch gegenereerde rapportages, logs en screenshots bij fouten.

📂 Bestandsomschrijvingen
🧪 Test Cases
01_auth.robot t/m 12_api_test.robot: De daadwerkelijke testscenario's.

Hybrid (04): Combineert API-logins met UI-acties voor maximale snelheid.

Data Driven (07, 11): Testen van meerdere scenario's (zoals inloggen) met verschillende datasets.

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