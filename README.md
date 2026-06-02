*This project has been created as part of the 42 curriculum by samalves.*

# 42 Mobile Piscine

## Description

This repository contains Flutter projects developed as part of the **42 Mobile Piscine** at **42 Berlin**.

The Mobile Piscine introduces mobile application development through small progressive modules. The projects in this repository focus on Flutter, Dart, UI construction, state management, navigation, API usage, geolocation, data display, and mobile app design.

The inspected repository contains projects from:

- `mobileModule00`
- `mobileModule01`
- `mobileModule02`
- `mobileModule03`

No `mobileModule04` or `mobileModule05` implementation was found in the current repository files.

## Piscine Overview

According to the general Mobile Piscine subject, the full piscine is structured as:

- Mobile 0: Basic of the mobile application
- Mobile 1: Structure and logic
- Mobile 2: API and data
- Mobile 3: Design
- Mobile 4: Auth and database
- Mobile 5: Manage data and display

This repository currently documents the modules and applications present in the codebase.

## Repository Structure

~~~text
Mobile/
  mobileModule00/
    ex00/
    ex01/
    ex02/
    calculator_app/

  mobileModule01/
    weather_app/

  mobileModule02/
    medium_weather_app/

  mobileModule03/
    advanced_weather_app/
~~~

Each project is a Flutter application with its own `pubspec.yaml`.

## Module Overview

### mobileModule00

This module introduces basic Flutter application structure, widgets, layout, state, and a calculator interface.

Projects present:

- `ex00`
- `ex01`
- `ex02`
- `calculator_app`

Implemented concepts:

- `MaterialApp`
- `Scaffold`
- `Container`
- `Column`
- `Row`
- `Text`
- `ElevatedButton`
- Basic layout composition
- Button callbacks
- `StatelessWidget`
- `StatefulWidget`
- `setState`
- Calculator UI
- Expression display
- Result display
- Basic calculator interaction

The `calculator_app` project uses the `math_expressions` package to parse and evaluate mathematical expressions.

### mobileModule01

This module introduces the structure of a weather application.

Project present:

- `weather_app`

Implemented concepts:

- App bar with search input
- `TextEditingController`
- `TabController`
- `TabBar`
- `TabBarView`
- Bottom navigation with tabs
- Basic state update from user input
- Initial weather app screen structure

The app contains three tabs:

- Currently
- Today
- Weekly

At this stage, the app displays entered location text across the tab views.

### mobileModule02

This module extends the weather application with real data and device features.

Project present:

- `medium_weather_app`

Implemented concepts:

- HTTP requests
- JSON parsing
- Open-Meteo weather API
- Open-Meteo geocoding API
- City search suggestions
- Current device location
- Location permission handling
- Reverse geocoding
- Current weather display
- Hourly forecast display
- Weekly forecast display
- Error message handling

The app uses:

- `http`
- `geolocator`
- `geocoding`

Weather data includes:

- Current temperature
- Wind speed
- Weather code description
- Hourly forecast
- Daily minimum and maximum temperatures
- Seven-day forecast

### mobileModule03

This module improves the weather app with design and data visualization.

Project present:

- `advanced_weather_app`

Implemented concepts:

- Background image asset
- Weather icons
- Charts with `fl_chart`
- Hourly temperature chart
- Weekly minimum and maximum temperature charts
- Improved visual presentation
- Weather condition mapping
- Search suggestions
- Geolocation
- API-driven forecast data

The app uses:

- `http`
- `geolocator`
- `geocoding`
- `fl_chart`

An image asset is included at:

~~~text
assets/background.png
~~~

## Main Applications

### Calculator App

Located at:

~~~text
mobileModule00/calculator_app
~~~

Features:

- Numeric input buttons
- Basic operators
- Clear and all-clear buttons
- Expression display
- Result display
- Expression evaluation with `math_expressions`

### Weather App

Located at:

~~~text
mobileModule01/weather_app
~~~

Features:

- Search field
- Location button
- Bottom tab navigation
- Currently, Today, and Weekly tabs
- Basic app structure and state handling

### Medium Weather App

Located at:

~~~text
mobileModule02/medium_weather_app
~~~

Features:

- City search with suggestions
- Geolocation
- Reverse geocoding
- Weather API integration
- Current weather
- Hourly forecast
- Weekly forecast
- Error handling

### Advanced Weather App

Located at:

~~~text
mobileModule03/advanced_weather_app
~~~

Features:

- Weather API integration
- Geolocation
- Search suggestions
- Current weather screen
- Today forecast screen
- Weekly forecast screen
- Weather icons
- Temperature charts
- Background image
- Improved visual design

## Instructions

Each project is a standalone Flutter application.

To run one project, enter its directory:

~~~sh
cd Mobile/mobileModule03/advanced_weather_app
~~~

Install dependencies:

~~~sh
flutter pub get
~~~

Run the app:

~~~sh
flutter run
~~~

Example for the calculator app:

~~~sh
cd Mobile/mobileModule00/calculator_app
flutter pub get
flutter run
~~~

Example for the advanced weather app:

~~~sh
cd Mobile/mobileModule03/advanced_weather_app
flutter pub get
flutter run
~~~

## Requirements

To build and run these projects, you need:

- Flutter SDK
- Dart SDK
- Android Studio or another Flutter-compatible IDE
- Android emulator, iOS simulator, or physical device
- Internet connection for weather API features
- Location permissions enabled for geolocation features

## Technologies Used

- Flutter
- Dart
- Material Design widgets
- Open-Meteo API
- Open-Meteo Geocoding API
- `http`
- `geolocator`
- `geocoding`
- `fl_chart`
- `math_expressions`

## Technical Skills Practiced

This repository focuses on:

- Mobile app development
- Flutter widget composition
- Dart programming
- Stateful UI
- User input handling
- Tab navigation
- App layout
- HTTP requests
- JSON parsing
- API integration
- Geolocation
- Reverse geocoding
- Error handling
- Data visualization
- Mobile UI design

## Skills Demonstrated

This project is relevant to:

- Software Engineering
- Mobile Development
- Frontend Development
- API Integration
- Product-oriented UI development

It does not directly focus on backend development, Linux systems programming, networking infrastructure, or cybersecurity. However, it demonstrates practical client-side development, API consumption, asynchronous programming, and user-facing application design.

## Resources

Classic references related to this project:

- Flutter documentation
- Dart documentation
- Flutter Material library documentation
- Open-Meteo API documentation
- Open-Meteo Geocoding API documentation
- `http` package documentation
- `geolocator` package documentation
- `geocoding` package documentation
- `fl_chart` package documentation
- `math_expressions` package documentation
- 42 Mobile Piscine general subject

## Use of AI

AI was used to help prepare this README file for GitHub presentation.

Specifically, AI was used to:

- Review the visible repository structure
- Identify the Flutter projects and modules present
- Summarize the implemented features based on the code
- Organize the README according to the requested 42 format
- Improve wording for clarity and recruiter readability
- Describe the technical skills demonstrated by the projects

AI was not used to write, modify, debug, or generate the source code of these projects.
No source files or project configuration files were modified as part of this README preparation.

## Author

- Intra: `samalves`
- School: 42 Berlin

## Notes

This README is based only on the files currently present in the repository and the general Mobile Piscine subject.

The module-specific subjects were not available during this documentation pass, so the feature descriptions are based on the inspected code rather than undocumented assumptions.

The repository includes generated Flutter project files and build-related files because it was prepared for upload as-is.
