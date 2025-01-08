//
//  ContentView.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

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
            .keyboardDismissable()

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
                    
                case .autoCompleteResults(let results):
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(results) { result in
                                SearchResultCard(autoCompleteResult: result) {
                                    Task {
                                        await viewModel.fetchWeather(for: result.name)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                case .currentWeather(let weather):
                    WeatherState(weather: weather)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            }
            .animation(.smooth, value: viewModel.viewState)
        }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            interactor: HomeInteractor(container: MockDependencies.shared.container)
        )
    )
}
