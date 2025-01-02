//
//  WeatherError.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

enum WeatherError: LocalizedError {
    case invalidURL
    case decodingError(Error)
    case invalidResponse
    case apiError(code: Int, message: String)
    case networkError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL format"
        case .decodingError(let error):
            return "Failed to process weather data: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .apiError(_, let message):
            return message
        case .networkError:
            return "No network detected,\n check your network and"
        }
    }
}

struct APIErrorResponse: Decodable {
    let error: ErrorDetail
    
    struct ErrorDetail: Decodable {
        let code: Int
        let message: String
    }
}
