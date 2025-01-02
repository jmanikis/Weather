//
//  MockNetworkManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

class MockNetworkManager: NetworkManagerProtocol {
    private(set) var isConnected: Bool = false
    private var statusChangeHandler: ((Bool) -> Void)?
    
    // For testing purposes
    private(set) var startMonitoringCalled = false
    private(set) var stopMonitoringCalled = false
    
    func startMonitoring(onStatusChange: @escaping (Bool) -> Void) {
        startMonitoringCalled = true
        statusChangeHandler = onStatusChange
        // Initial callback with current status
        onStatusChange(isConnected)
    }
    
    func stopMonitoring() {
        stopMonitoringCalled = true
        statusChangeHandler = nil
    }
    
    // Helper method for tests to simulate network status changes
    func simulateNetworkStatusChange(isConnected: Bool) {
        self.isConnected = isConnected
        statusChangeHandler?(isConnected)
    }
}
