# Robot Framework Automation Suite

Dit project is een robuust en schaalbaar testautomatisering framework gebouwd met **Robot Framework**. Het framework is ontworpen volgens moderne "best practices", waarbij de focus ligt op onderhoudbaarheid, snelheid en de combinatie van Frontend (UI) en Backend (API) testen.

## 🚀 Project Architectuur

Er is gekozen voor een modulaire opbouw om het framework "future-proof" te maken:

* **`common.resource`**: Het centrale zenuwcentrum. Bevat gedeelde instellingen, globale variabelen (URL's, credentials) en herbruikbare keywords. Dit voorkomt dubbele code (DRY-principe).
* **`tests/`**: Bevat de testsuites, onderverdeeld in logische lagen (UI, API, Hybrid).
* **`results/`**: Automatisch gegenereerde rapportages, logs en screenshots bij fouten.

## 🛠️ Testmethodieken

In dit framework worden drie verschillende teststrategieën toegepast:

1.  **UI Testing (Frontend)**: Gebruik van de `Browser` library (Playwright) voor stabiele browser-interactie. Dankzij de *auto-waiting* functionaliteit zijn deze tests minder foutgevoelig dan traditionele Selenium tests.
2.  **API Testing (Backend)**: Directe communicatie met de server via de `RequestsLibrary`. Dit biedt razendsnelle validatie van de bedrijfslogica zonder de overhead van een grafische interface.
3.  **Hybrid Testing**: De meest geavanceerde laag. Hierbij wordt ingelogd via een API-call, waarna het sessie-cookie wordt geïnjecteerd in de browser. Dit bespaart aanzienlijke testtijd door trage UI-loginpaden over te slaan.

## 📈 Waarom deze opzet?

* **Onderhoudbaarheid**: Door variabelen in een centraal `.resource` bestand te beheren, is het framework met minimale inspanning aan te passen aan nieuwe omgevingen.
* **Stabiliteit**: In plaats van onbetrouwbare `Sleep` commando's, vertrouwt het framework op de intelligente wachtmechanismes van Playwright.
* **Foutanalyse**: Bij een falende test wordt er in de `Test Teardown` automatisch een screenshot gemaakt, wat de "Root Cause Analysis" enorm versnelt.

## 💻 Installatie & Gebruik

### Vereisten
* Python 3.x
* Robot Framework
* Browser Library (Playwright)
* Requests Library

### Installatie commando's
```bash
pip install robotframework robotframework-browser robotframework-requests
rfbrowser init