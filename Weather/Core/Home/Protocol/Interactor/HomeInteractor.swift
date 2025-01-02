//
//  HomeInteractor.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
struct HomeInteractor: HomeProtocol {
    let weatherManager: WeatherManager
    let storageManager: StorageManager
    let networkManager: NetworkManager
    
    init(container: DependencyContainer) {
        self.weatherManager = container.resolve(WeatherManager.self)!
        self.storageManager = container.resolve(StorageManager.self)!
        self.networkManager = container.resolve(NetworkManager.self)!
    }

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
    
    func stopMonitoring() {
        networkManager.stopMonitoring()
    }
}
