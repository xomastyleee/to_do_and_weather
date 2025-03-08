# To-Do & Weather App

[![Flutter CI](https://github.com/[username]/to_do_and_weather/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/[username]/to_do_and_weather/actions/workflows/flutter_ci.yml)
[![codecov](https://codecov.io/gh/[username]/to_do_and_weather/branch/main/graph/badge.svg)](https://codecov.io/gh/[username]/to_do_and_weather)

A Flutter application that combines a To-Do list with weather information using the OpenWeatherMap One Call API 3.0.

## Features

- Display current weather using OpenWeatherMap One Call API 3.0
- Manage tasks with categories
- Filter tasks by category and completion status
- Beautiful and modern UI with Material Design

## Getting Started

### Prerequisites

- [FVM (Flutter Version Management)](https://fvm.app)
- OpenWeatherMap API key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/[username]/to_do_and_weather.git
cd to_do_and_weather
```

2. Install the correct Flutter version using FVM:
```bash
fvm install
fvm use
```

3. Install dependencies:
```bash
fvm flutter pub get
```

4. Create a `.env` file in the root directory and add your OpenWeatherMap API key:
```
OPENWEATHERMAP_API_KEY=your_api_key_here
```

5. (Optional) Update default coordinates in `lib/core/constants/app_constants.dart` for your location. Default is set to Kyiv (50.4501, 30.5234).

6. Run the app:
```bash
fvm flutter run
```

## Running Tests

To run all tests with coverage:
```bash
fvm flutter test --coverage
```

To view the coverage report:
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

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
