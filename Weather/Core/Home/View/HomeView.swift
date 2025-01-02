//
//  ContentView.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    
    let city = "Mock City"
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText) {}
            if !city.isEmpty {
                WeatherState(weather: .mockData)
            } else {
                Group {
                    VStack {
                        Text("No City Selected")
                        Text("Please search for a city")
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
