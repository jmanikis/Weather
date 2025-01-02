# Weather Tracker

## Overview
Weather Tracker is a simple iOS app built with SwiftUI that allows users to search for a city and display its current weather conditions. The app persists the selected city for convenience and ensures that the weather details are available on every launch. 

## Features
- Search for a city and view its weather details, including:
  - City name
  - Temperature
  - Weather condition (with icon)
  - Humidity
  - UV index
  - "Feels like" temperature
- Persistent storage for the selected city using `UserDefaults`.
- API integration with [WeatherAPI.com](https://www.weatherapi.com/).
- Clean and testable MVVM architecture.

## Requirements
- iOS 18.0+
- Xcode 16.0+
- Swift 5.5+

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/jmanikis/Weather.git
  ```
2. Navigate to project folder:

   ```
   cd Weather
   ```
3. Open the project in Xcode:
   ```bash
   open Weather.xcodeproj
   ```
4. Obtain an API key from [WeatherAPI.com](https://www.weatherapi.com/).
5. Add your API key:
   - Open the `Constants.swift` file located in the `Weather/Utilities/Constants` directory.
   - Replace the placeholder `YOUR_API_KEY` with your actual API key:
     ```swift
     struct Constants {
         static let apiKey = "YOUR_API_KEY"
     }
     ```
5. Build and run the project on a simulator or device.

## Usage
1. Launch the app.
2. If no city is selected, use the search bar to find a city by name.
3. Tap on the search result to view the weather details for the selected city.
4. The selected city and its weather details will persist across app launches.
