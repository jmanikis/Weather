//
//  StorageManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

protocol StorageServiceProtocol {
    func saveCity(_ city: String)
    func getCity() -> String?
    func clearCity()
}

// MARK: - Storage Service
class StorageManager: StorageServiceProtocol {
    private let defaults = UserDefaults.standard
    private let cityKey = "savedCity"
    
    func saveCity(_ city: String) {
        defaults.set(city, forKey: cityKey)
    }
    
    func getCity() -> String? {
        defaults.string(forKey: cityKey)
    }

    func clearCity() {
        saveCity("")
    }
}
