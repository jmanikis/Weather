//
//  HomeViewModel.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {

    private let interactor: HomeProtocol
    
    @Published private(set) var viewState: HomeViewStateEnum = .empty
    @Published var searchQuery = "" {
        didSet {
            Task {
                await handleAutoComplete()
            }
        }
    }
    @Published var isConnected = true {
        didSet {
            if oldValue != isConnected {
                Task {
                    await loadSavedCity()
                }
            }
        }
    }

    init(interactor: HomeProtocol) {
        self.interactor = interactor
        setupNetworkMonitoring()
    }

    deinit {
        interactor.stopMonitoring()
    }

    private func handleEmptySearch() async {
        if let savedCity = interactor.getCity() {
            await fetchWeather(for: savedCity)
        } else {
            viewState = .empty
        }
    }
    
    private func setupNetworkMonitoring() {
        interactor.startMonitoring { [weak self] isConnected in
            guard let self else { return }
            self.isConnected = isConnected
            if !isConnected {
                self.viewState = .error(.invalidResponse)
            }
        }
    }
    
    func clearSavedCity() {
        interactor.clearCity()
        viewState = .empty
        searchQuery = ""
    }
    
    func loadSavedCity() async {
        if let savedCity = interactor.getCity(), !savedCity.isEmpty {
            await fetchWeather(for: savedCity)
        } else {
            viewState = .empty
        }
    }
    
    func searchCity() async {
        guard !searchQuery.isEmpty else {
            await handleEmptySearch()
            return
        }
        await fetchWeather(for: searchQuery)
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
        interactor.saveCity(weather.location.name)
    }
    
    func fetchWeather(for city: String) async {
        guard isConnected else {
            viewState = .error(.networkError)
            return
        }

        viewState = .loading
        
        do {
            let weather = try await interactor.fetchWeather(cityName: city)
//            if isSearch {
//                viewState = .searchResults(weather)
//            } else {
                viewState = .currentWeather(weather)
                interactor.saveCity(weather.location.name)
//            }
        } catch let weatherError as WeatherError {
            viewState = .error(weatherError)
        } catch {
            viewState = .error(.invalidResponse)
        }
    }
}

extension HomeViewModel {
    func handleAutoComplete() async {
        guard !searchQuery.isEmpty else {
            if let savedCity = interactor.getCity() {
                await fetchWeather(for: savedCity)
            } else {
                viewState = .empty
            }
            return
        }
        
        do {
            let results = try await interactor.fetchAutoCompleteResults(query: searchQuery)
            viewState = .autoCompleteResults(results)
        } catch {
            viewState = .error(.invalidResponse)
        }
    }
}
