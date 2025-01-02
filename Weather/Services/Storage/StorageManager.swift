//
//  StorageManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

protocol StorageManagerProtocol {
    func saveCity(_ city: String)
    func getCity() -> String?
    func clearCity()
}

class StorageManager: StorageManagerProtocol {
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
