//
//  NetworkManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import Foundation
import Network

protocol NetworkManaging {
    var isConnected: Bool { get }
    func startMonitoring(onStatusChange: @escaping (Bool) -> Void)
    func stopMonitoring()
}

class NetworkManager: NetworkManaging {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected: Bool {
        monitor.currentPath.status == .satisfied
    }
    
    func startMonitoring(onStatusChange: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                onStatusChange(path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
