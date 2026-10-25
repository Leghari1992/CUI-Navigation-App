# CUI Campus Guide Application

A smart campus app for **COMSATS University Islamabad (CUI)**. It combines outdoor GPS navigation, indoor navigation with BLE beacons, and a fingerprint-based faculty attendance system, all in one Android app.

> Final Year Project, BS Computer Engineering, Department of Computer Engineering, COMSATS University Islamabad (July 2025).

---

## Why this project

A survey of 100 CUI students found that:

- 80% have trouble finding key places on campus
- 82% have seen outdated event information
- 83% find faculty availability and medical centre information hard to get
- 89% want one single app for campus information

This app tries to fix those problems in one place.

## Features

| Feature | What it does |
|---|---|
| Outdoor navigation | Google Maps markers for campus locations with turn-by-turn directions |
| Indoor navigation | BLE beacons and RSSI-based positioning, shown on a Next.js indoor map inside the app |
| Faculty attendance | ESP32 + R307s fingerprint sensor. Entry/exit is logged and sent to Firestore |
| Faculty availability | Live "available / not available" status in the app, plus LED indicators outside offices |
| Virtual assistant | Chatbot built with Dialogflow for campus questions |
| Academic calendar and events | Dates, deadlines, and event list |
| QR code scanner | Scan codes around campus for building info and event registration |
| Building information | Departments, services, and facilities per building |
| Medical centre | Contacts, clinic hours, and medical support info |
| Transportation | Routes, schedules, and contact details |
| Notifications | Alerts and announcements via Firebase Cloud Messaging |
| Feedback | Users can send suggestions or report problems |

## System overview

```
 Android app (Flutter / Dart)
   |-- Google Maps ............. outdoor navigation
   |-- WebView (Next.js map) ... indoor navigation using BLE beacons
   |-- Dialogflow API .......... virtual assistant
   '-- Firebase ................ Auth, Firestore, Cloud Messaging
                                   ^
                                   | HTTPS (JSON)
 ESP32 + R307s fingerprint sensor -'
   (LCD, LEDs, buzzer, push buttons)
```

## Tech stack

**Software**
- Flutter (Dart), built in Android Studio
- Firebase: Authentication, Cloud Firestore, Cloud Messaging
- Google Maps
- Dialogflow (Google Cloud)
- Next.js (React) for the indoor map

**Hardware**
- ESP32 Dev Module (Arduino IDE, C/C++)
- R307s fingerprint sensor (UART)
- 16x2 LCD, LEDs, 5V buzzer, 4 push buttons
- BLE beacons (5 beacons placed in the student lobby of Academic Block-I)

## Project structure

> Edit this to match your actual folders.

```
.
|-- app/            # Flutter Android app
|-- indoor-map/     # Next.js indoor map (loaded in the app through WebView)
|-- firmware/       # ESP32 fingerprint attendance code (Arduino)
|-- docs/           # Report and diagrams
'-- README.md
```

## Getting started

### 1. Flutter app

Requirements: Flutter SDK, Android Studio, an Android phone with GPS and Bluetooth.

```bash
cd app
flutter pub get
flutter run
```

You need to add your own keys (these are not included in the repo):

- `android/app/google-services.json` from your Firebase project
- Google Maps API key (in `AndroidManifest.xml`)
- Dialogflow credentials / API key

### 2. Indoor map (Next.js)

```bash
cd indoor-map
npm install
npm run dev
```

Point the app's WebView to the URL where this map is running or deployed.

### 3. Fingerprint attendance (ESP32)

1. Open the sketch in Arduino IDE and install the ESP32 board package.
2. Install the fingerprint sensor, LCD, and Firebase/HTTP libraries used by the sketch.
3. Enter your own Wi-Fi name, password, and Firestore details in the config section.
4. Upload to the ESP32 and open the Serial Monitor at the baud rate set in the sketch.

On boot, the device connects to Wi-Fi, syncs time with NTP, and sets up the LCD and sensor. Each scan is matched against stored fingerprints, marked as entry or exit, and the latest status is sent to Firestore as JSON. Fingerprint data is stored in EEPROM.

## Known limitations

- Android only (no iOS yet)
- Indoor navigation covers only the ground floor of one building
- BLE beacon range drops from about 30 m (rated) to about 2-5 m indoors because of obstacles
- The attendance device needs stable Wi-Fi to sync in real time
- Dry or wet fingers can cause failed fingerprint scans

## Future work

- More accurate indoor positioning and more beacons across campus
- Extra biometric options such as face recognition
- A smarter virtual assistant
- iOS support

## Team

| Name | Reg. No. |
|---|---|
| Tehreem Fatima Leghari | CIIT/FA21-BCE-071/ISB |
| Kaif-Ul-Wara | CIIT/FA21-BCE-032/ISB |
| Hifza Bibi | CIIT/FA21-BCE-078/ISB |

**Supervisor:** Asad Ali Malik, Lecturer, Department of Computer Engineering, CUI Islamabad
**Co-supervisors:** Shafia Hussain, Arjmand Fatima

## Sustainable Development Goals

SDG 4 (Quality Education), SDG 9 (Industry, Innovation and Infrastructure), SDG 11 (Sustainable Cities and Communities).

## License

Add a license here (for example MIT), or state that this is an academic project.
