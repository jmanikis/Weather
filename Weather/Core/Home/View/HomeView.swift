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
        VStack(spacing: 20) {
            SearchBarView(
                searchText: $viewModel.searchQuery,
                onSubmit: {
                    Task {
                        await viewModel.handleSubmit()
                    }
                }
            )

            contentView
        }
        .padding(20)
        .task {
            await viewModel.loadSavedCity()
        }
    }

    @ViewBuilder
    private var contentView: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(maxHeight: .infinity, alignment: .center)
                
            case .empty:
                EmptyStateView()
                    .frame(maxHeight: .infinity, alignment: .center)
                
            case .error(let error):
                ErrorState(error: error)
                    .frame(maxHeight: .infinity, alignment: .center)
                
            case .searchResults(let weather):
                SearchResultCard(weather: weather) {
                    viewModel.selectCity(weather)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .transition(.opacity)
                .padding(.vertical, 12)

                if case .currentWeather(let currentWeather) = viewModel.viewState {
                    WeatherState(weather: currentWeather)
                }

            case .currentWeather(let weather):
                WeatherState(weather: weather)

            }
        }
        .animation(.smooth, value: viewModel.viewState)
    }
}

#Preview {
    HomeView()
}
