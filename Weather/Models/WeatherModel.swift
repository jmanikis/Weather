//
//  WeatherModel.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import Foundation

// MARK: - Weather Model
struct WeatherModel: Codable {
    let location: Location
    let current: Current
}

// MARK: - Location
struct Location: Codable {
    let name: String
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let humidity: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let uv: Double

    // Define custom coding keys to match JSON
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case humidity
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
}

// MARK: - Helper Extensions
extension WeatherModel {
    var displayTemperature: String {
        String(format: "%.0f°", current.tempC)
    }
    
    var displayFeelsLike: String {
        String(format: "%.0f°", current.feelslikeC)
    }
    
    var displayHumidity: String {
        "\(String(current.humidity))%"
    }
    
    var displayUV: String {
        String(format: "%.0f", current.uv)
    }
    
    var weatherIconUrl: URL? {
        guard let icon = current.condition.icon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https:\(icon)") else {
            return nil
        }
        return url
    }
}

// Mock Weather Data
extension WeatherModel {
    static let mockData = WeatherModel(
        location: Location(name: "London"),
        current: Current(
            tempC: 18.0,
            condition: Condition(
                text: "Partly cloudy",
                icon: "//picsum.photos/200"
            ),
            humidity: 72,
            feelslikeC: 17.5,
            feelslikeF: 63.5,
            uv: 4.0
        )
    )
}
