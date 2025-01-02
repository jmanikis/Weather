//
//  SearchResultCard.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct SearchResultCard: View {
    let weather: WeatherModel
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 16) {
                // Left side: City info
                VStack(alignment: .leading, spacing: 4) {
                    Text(weather.location.name)
                        .font(.system(size: 20, weight: .semibold))
                    Text(weather.displayTemperature)
                        .font(.system(size: 60, weight: .medium))

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 16)
                .foregroundStyle(AppColors.veryDarkGrey)
                
                AsyncImage(url: weather.weatherIconUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 83, height: 67)
                } placeholder: {
                    ProgressView()
                }
                .padding(.vertical, 25)
            }
            .padding(.horizontal, 31)
        }
        .background(
            RoundedRectangle(cornerRadius: 16 )
                .foregroundStyle(AppColors.veryLightGrey)
        )
    }
}

#Preview {
    SearchResultCard(weather: .mockData, onSelect: {})
}
