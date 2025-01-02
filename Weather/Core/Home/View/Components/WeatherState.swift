//
//  WeatherCard.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

enum WeatherViewState {
    case loading
    case empty
    case error(WeatherError)
    case searchResults(WeatherModel)
    case currentWeather(WeatherModel)
}

struct WeatherState: View {
    let weather: WeatherModel

    var body: some View {
        VStack(spacing: 35) {
            weatherInfoCard
            currentWeatherStatsCard
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    var weatherInfoCard: some View {
        VStack(spacing: 24) {
                AsyncImage(url: weather.weatherIconUrl) { image in
                    image.resizable()
                        .frame(width: 123, height: 113)
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                HStack(spacing: 11) {
                    Text(weather.location.name)
                        .font(.system(size: 30, weight: .semibold))
                    Image(systemName: "location.fill")
                        .font(.system(size: 21))
                }
                .foregroundStyle(AppColors.veryDarkGrey)
                
                Text(weather.displayTemperature)
                    .font(.system(size: 70, weight: .medium))
            }
    }

    var currentWeatherStatsCard: some View {
        HStack {
            StatBox(title: "Humidity", value: weather.displayHumidity, width: 60, size: 12)
            StatBox(title: "UV", value: weather.displayUV, width: 43, size: 12)
            StatBox(title: "Feels Like", value: weather.displayFeelsLike, width: 60, size: 8)
        }
        .frame(height: 75)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(AppColors.veryLightGrey))
    }
}

#Preview {
    WeatherState(weather: .mockData)
}
