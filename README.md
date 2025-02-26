# BasiGo D.I.R.T (Dispatch & Incident Reporting Tool)

## Build/Run Instructions

### Prerequisites

Ensure you have the following installed:

- Flutter SDK (`v3.24.3`)
- Dart SDK (`3.5.3`)
- A physical or virtual device set up for Android/iOS

### Running the App

1. Add and enf file at the root of the project. `.env`
2. Run this command to generate the necessary codes needed   ```chmod +x ./setup.sh && ./setup.sh```.
3. Run the app to either iOS (simulator) or Android (emulator)

### Additional Setup for Dependencies

- You will need a `GoogleApiKey` in order to use location services, simply add it to the `.env` file before running the `./setup` command. Example: `GOOGLE_API_KEY=<key>`. Refer to the `.env.example`

## Architecture Overview

### Project Structure

- The project uses **Clean Architecture**, which is shown in the diagram below.
- Project has also tried to stick to the **SOLID** design principles though with some trade-offs here and there.

``` sh
lib/
│── core/                   # Core utilities, services, widgets, routes, middlewares, types
│── config/                 # Config info - theme, env, assets
│── modules/                # Feature-based structure
│   ├── auth/               # Auth module
│   ├── incidents/          # Incident module
│       ├── data/           # Models, datasources, repository (implementaions)
│       ├── domain/         # Usecases, entities, repositories (abstract)
│       ├── presentation/   # Pages, controllers, middlewares, widgets
└── firebase_options.dart   # firebase configuration
└── basigo_dirt.dart        # Main entry app
└── main.dart
test/
│── incidents/              # Incident module tests
│── mocks/                  # Test mocks for Datasources and Controllers
```

### State Management Approach

This project uses **GetX** for state management because of its simplicity, high performance, minimal boilerplate and the ability to handles dependency injection and routing efficiently. GetX also offers addistional addons used accrosed this prject e.g utilities e.t.c

### Offline Sync and Real-time Updates

- **Offline Support**: Implemented using **Hive** for local persistence, ensuring data is available when offline.
- **Real-time Updates**: Uses **Firebase Firestore** (Streams) to fetch real-time data when online.
- **observe_internet_connectivity** to listen to activity changes and update UI and other logics.

#### Walkthrough

- So data is always on realtime, (be it offline or onnline) through the use of streams. When a user(driver) goes offline and tries to create an incident, It (incident) is saved locally on a hive box with all the information provided. When the device goes online, there's a listener thats updated in the background and in turn triggers a sync which saves all the offline data to the server(firebase).
- In terms of UI, the user will see a banner at the bottom of the device when offline (just for information purposes), and will see a banner telling him/her the device is back online.

## Tests

- The project has tests for the core functionalities.
  1. **Unit Tests** for functiionalities related offline capabilities and realt-time rendering
  2. **Widget Tests** for key incident specific pages and actions. (Just to make sure rendering is done well)

## Optional Extras

- Auth module -- Just login and role-based-access (RBAC) management. No signup page e.t.c
- Anlytics Dashboard -- A simple dashboard with key data shown when a dispatch has logged in.
