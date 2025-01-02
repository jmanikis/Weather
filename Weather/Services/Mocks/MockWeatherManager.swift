//
//  MockWeatherManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

@MainActor
class MockWeatherManager: WeatherManagerProtocol {
    // For testing purposes
    private(set) var fetchWeatherCalled = false
    private(set) var lastRequestedCity: String?
    
    // Configurable responses for testing
    var shouldThrowError = false
    var errorToThrow: WeatherError?
    var weatherToReturn: WeatherModel = .mockData
    private(set) var fetchCount = 0
    
    func fetchWeather(cityName: String) async throws -> WeatherModel {
        fetchWeatherCalled = true
        lastRequestedCity = cityName
        fetchCount += 1
        
        if shouldThrowError {
            throw errorToThrow ?? WeatherError.invalidResponse
        }
        
        return weatherToReturn
    }
    
    // Helper method to reset the mock state
    func reset() {
        fetchWeatherCalled = false
        lastRequestedCity = nil
        shouldThrowError = false
        errorToThrow = nil
        weatherToReturn = .mockData
        fetchCount = 0
    }
}
