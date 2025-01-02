//
//  Dependencies.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
struct Dependencies {
    let container: DependencyContainer
    let weatherManager = WeatherManager()
    let storageManager = StorageManager()
    let networkManager = NetworkManager()
    
    init() {
        let container = DependencyContainer()
        container.register(WeatherManager.self, service: weatherManager)
        container.register(StorageManager.self, service: storageManager)
        container.register(NetworkManager.self, service: networkManager)
        self.container = container
    }
}

@MainActor
class MockDependencies {
    static let shared = MockDependencies()
    
    let weatherManager = MockWeatherManager()
    let storageManager = MockStorageManager()
    let networkManager = MockNetworkManager()
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(MockWeatherManager.self, service: weatherManager)
        container.register(MockStorageManager.self, service: storageManager)
        container.register(MockNetworkManager.self, service: networkManager)
        return container
    }
}
