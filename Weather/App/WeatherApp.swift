//
//  WeatherApp.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@main
struct WeatherApp: App {
    var dependencies: Dependencies
    var container: DependencyContainer

    init() {
        self.dependencies = Dependencies()
        self.container = dependencies.container
    }

    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeViewModel(
                    interactor: HomeInteractor(container: container)
                )
            )
        }
    }
}
