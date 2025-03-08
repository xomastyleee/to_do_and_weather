# To-Do & Weather App

A task management and weather display application developed using Flutter and Clean Architecture principles.

## Features

- Task management (add, edit, delete, mark as completed)
- Color-coded task categories
- Filter tasks by category and completion status
- Display current weather using OpenWeatherMap One Call API 3.0
- Persist data between sessions using Hive

## Architecture

The application is built using Clean Architecture and SOLID principles:

- **Domain Layer**: Contains business logic, entities, and repository interfaces
- **Data Layer**: Implements repositories and data sources
- **Presentation Layer**: Contains UI components and BLoC for state management

## Technologies

- **Flutter**: Framework for cross-platform application development
- **BLoC**: State management pattern
- **Hive**: Lightweight NoSQL database for local data storage
- **HTTP**: Library for network requests
- **Equatable**: Library for simplifying object comparison

## Installation

1. Clone the repository:
```
git clone https://github.com/yourusername/to_do_and_weather.git
```

2. Install dependencies:
```
flutter pub get
```

3. Generate code for Hive:
```
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Create a `.env` file in the root directory based on `.env.example`:
```
cp .env.example .env
```

5. Add your OpenWeatherMap API key to the `.env` file:
```
WEATHER_API_KEY=your_api_key_here
```

6. (Optional) Update default coordinates in `lib/core/constants/app_constants.dart` for your location:
```dart
static const double defaultLat = 50.4501; // Your city latitude
static const double defaultLon = 30.5234; // Your city longitude
```

7. Run the application:
```
flutter run
```

## Library Selection Rationale

- **BLoC**: Chosen for state management as it provides a clear separation of business logic and UI, and scales well as the application grows.
- **Hive**: Selected for local data storage due to its simplicity, performance, and lack of dependency on native libraries.
- **HTTP**: Chosen for network operations due to its simplicity and sufficient functionality for working with REST APIs.
- **Equatable**: Simplifies object comparison, which is especially useful when working with BLoC.

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```
