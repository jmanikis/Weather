//
//  HomeProtocol.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
protocol HomeProtocol {
    // MARK: Weather functions
    func fetchWeather(cityName: String) async throws -> WeatherModel
    
    // MARK: Storage Functions
    func getCity() -> String?
    func saveCity(_ city: String)
    func clearCity()
    
    // MARK: Network Functions
    func startMonitoring(onStatusChange: @escaping (Bool) -> Void)
    nonisolated func stopMonitoring()
}
