//
//  WeatherStateEnum.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

enum HomeViewStateEnum: Equatable {
    case loading
    case empty
    case error(WeatherError)
    case searchResults(WeatherModel)
    case currentWeather(WeatherModel)

    static func == (lhs: HomeViewStateEnum, rhs: HomeViewStateEnum) -> Bool {
        return true
    }
}
