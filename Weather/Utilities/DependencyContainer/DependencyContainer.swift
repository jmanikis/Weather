//
//  DependencyContainer.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

@MainActor
class DependencyContainer: ObservableObject {
    @Published private(set) var services: [String: Any] = [:]
    
    func register<T>(_ type: T.Type, service: T) {
        let key = "\(type)"
        services[key] = service
    }
    
    func register<T>(_ type: T.Type, service: () -> T) {
        let key = "\(type)"
        services[key] = service()
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = "\(type)"
        return services[key] as? T
    }
}
