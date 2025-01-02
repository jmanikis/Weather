//
//  ContentView.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchQuery) {
                Task {
                    await viewModel.handleSubmit()
                }
            }
            switch viewModel.viewState {
            case .loading:
                ProgressView()
            case .empty:
                Group {
                    VStack {
                        Text("No City Selected")
                        Text("Please search for a city")
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
            case .error(let weatherError):
                Text("error: \(weatherError)")
            case .searchResults(let weatherModel):
                Text("Search results: \(weatherModel.location.name)")
            case .currentWeather(let weatherModel):
                WeatherState(weather: weatherModel)
            }
        }
        .padding()
        .task {
            await viewModel.loadSavedCity()
        }
    }
}

#Preview {
    HomeView()
}
