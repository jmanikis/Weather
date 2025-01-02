////
////  WeatherTests.swift
////  WeatherTests
////
////  Created by JC Manikis on 2025-01-01.
////
import Testing
import SwiftUI
@testable import Weather

@MainActor
struct MockHomeInteractor: HomeProtocol {
    let weatherManager = MockWeatherManager()
    let storageManager = MockStorageManager()
    let networkManager = MockNetworkManager()

    
    func fetchWeather(cityName: String) async throws -> WeatherModel {
        try await weatherManager.fetchWeather(cityName: cityName)
    }
    
    func getCity() -> String? {
        storageManager.getCity()
    }
    
    func saveCity(_ city: String) {
        storageManager.saveCity(city)
    }
    
    func clearCity() {
        storageManager.clearCity()
    }
    
    func startMonitoring(onStatusChange: @escaping (Bool) -> Void) {
        networkManager.startMonitoring { isConnected in
            DispatchQueue.main.async {
                onStatusChange(isConnected)
            }
        }
    }
    
    nonisolated func stopMonitoring() {
        networkManager.stopMonitoring()
    }
}

import Testing
import SwiftUI
@testable import Weather

@MainActor
struct HomeViewModelTests {
    @Test("Weather search succeeds with valid city")
    func testSuccessfulWeatherSearch() async throws {
        // Setup
        let mockInteractor = MockHomeInteractor()
        let viewModel = HomeViewModel(interactor: mockInteractor)
        
        // Test
        viewModel.searchQuery = "Montreal"
        await viewModel.searchCity()
        
        // Assert
        #expect(mockInteractor.weatherManager.fetchWeatherCalled)
        #expect(mockInteractor.weatherManager.lastRequestedCity == "Montreal")
        #expect(mockInteractor.weatherManager.fetchCount == 1)
    }
    
    @Test("Weather search fails with invalid city")
    func testFailedWeatherSearch() async throws {
        // Setup
        let mockInteractor = MockHomeInteractor()
        mockInteractor.weatherManager.shouldThrowError = true
        mockInteractor.weatherManager.errorToThrow = .apiError(code: 400, message: "CityNotFound")
        let viewModel = HomeViewModel(interactor: mockInteractor)
        
        // Test
        viewModel.searchQuery = "NonexistentCity"
        await viewModel.searchCity()
        
        // Assert
        #expect(mockInteractor.weatherManager.fetchWeatherCalled)
        #expect(mockInteractor.weatherManager.lastRequestedCity == "NonexistentCity")
    }
    
    @Test("Empty search query returns empty state")
    func testEmptySearchQuery() async throws {
        // Setup
        let mockInteractor = MockHomeInteractor()
        let viewModel = HomeViewModel(interactor: mockInteractor)
        
        // Test
        viewModel.searchQuery = ""
        await viewModel.searchCity()
        
        // Assert
        #expect(viewModel.viewState == .empty)
        #expect(!mockInteractor.weatherManager.fetchWeatherCalled)
        #expect(mockInteractor.weatherManager.fetchCount == 0)
    }
}
