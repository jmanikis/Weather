//
//  MockStorageManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

class MockStorageManager: StorageManagerProtocol {
    // In-memory storage instead of UserDefaults
    private var storedCity: String?
    
    // For testing purposes
    private(set) var saveCityCalled = false
    private(set) var getCityCalled = false
    private(set) var clearCityCalled = false
    
    func saveCity(_ city: String) {
        saveCityCalled = true
        storedCity = city
    }
    
    func getCity() -> String? {
        getCityCalled = true
        return storedCity
    }
    
    func clearCity() {
        clearCityCalled = true
        storedCity = nil
    }
    
    // Helper method to reset the mock state
    func reset() {
        storedCity = nil
        saveCityCalled = false
        getCityCalled = false
        clearCityCalled = false
    }
}
