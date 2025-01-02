//
//  HomeViewModel.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    let weatherManager = WeatherManager()
    let storageManager = StorageManager()
    
    @Published private(set) var viewState: HomeViewStateEnum = .empty
    @Published var searchQuery = ""
    @Published var isConnected = true {
        didSet {
            if oldValue != isConnected {
                Task {
                    await loadSavedCity()
                }
            }
        }
    }

    private func handleEmptySearch() async {
        if let savedCity = storageManager.getCity() {
            await fetchWeather(for: savedCity, isSearch: false)
        } else {
            viewState = .empty
        }
    }
    
    func clearSavedCity() {
        storageManager.clearCity()
        viewState = .empty
        searchQuery = ""
    }
    
    func loadSavedCity() async {
        if let savedCity = storageManager.getCity(), !savedCity.isEmpty {
            await fetchWeather(for: savedCity, isSearch: false)
        } else {
            viewState = .empty
        }
    }
    
    func searchCity() async {
        guard !searchQuery.isEmpty else {
            await handleEmptySearch()
            return
        }
        await fetchWeather(for: searchQuery, isSearch: true)
    }
    
    func handleSubmit() async {
        if searchQuery.isEmpty {
            clearSavedCity()
        } else {
            await searchCity()
        }
    }
    
    func selectCity(_ weather: WeatherModel) {
        viewState = .currentWeather(weather)
        searchQuery = ""
        storageManager.saveCity(weather.location.name)
    }
    
    private func fetchWeather(for city: String, isSearch: Bool) async {
        guard isConnected else {
            viewState = .error(.networkError)
            return
        }

        viewState = .loading
        
        do {
            let weather = try await weatherManager.fetchWeather(cityName: city)
            if isSearch {
                viewState = .searchResults(weather)
            } else {
                viewState = .currentWeather(weather)
            }
        } catch let weatherError as WeatherError {
            viewState = .error(weatherError)
        } catch {
            viewState = .error(.invalidResponse)
        }
    }
}
