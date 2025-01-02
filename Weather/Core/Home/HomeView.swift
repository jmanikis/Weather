//
//  ContentView.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText) {}
            Group {
                VStack {
                    Text("No City Selected")
                    Text("Please search for a city")
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
