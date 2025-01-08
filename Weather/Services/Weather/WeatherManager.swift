//
//  WeatherManager.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import Foundation

// MARK: - Protocols
protocol WeatherManagerProtocol {
    func fetchWeather(cityName: String) async throws -> WeatherModel
    func fetchAutoCompleteResults(query: String) async throws -> [AutoCompleteResult]
}

actor WeatherManager: WeatherManagerProtocol {
    
    private let apiKey = Constants.apiKey
    private let baseURL = URL(string: "https://api.weatherapi.com/v1/current.json")!
    private let autoCompleteURL = URL(string: "https://api.weatherapi.com/v1/search.json")!
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private let session = URLSession.shared
    
    func fetchWeather(cityName: String) async throws -> WeatherModel {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "aqi", value: "no")
        ]
        
        guard !apiKey.isEmpty, apiKey != "YOUR_API_KEY" else {
            throw WeatherError.invalidAPIKey
        }
        
        guard let url = components.url else {
            throw WeatherError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200:
                return try decoder.decode(WeatherModel.self, from: data)
            default:
                if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    throw WeatherError.apiError(code: apiError.error.code,
                                              message: apiError.error.message)
                }
                throw WeatherError.invalidResponse
            }
        } catch let decodingError as DecodingError {
            throw WeatherError.decodingError(decodingError)
        } catch {
            throw error
        }
    }
    
    func fetchAutoCompleteResults(query: String) async throws -> [AutoCompleteResult] {
            // Create URL with query parameters
        var urlComponents = URLComponents(url: autoCompleteURL, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: query)
            ]

            // Ensure the URL is valid
            guard let url = urlComponents.url else {
                throw URLError(.badURL)
            }

            // Perform the network request
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decode JSON response
            return try JSONDecoder().decode([AutoCompleteResult].self, from: data)
        }
}
