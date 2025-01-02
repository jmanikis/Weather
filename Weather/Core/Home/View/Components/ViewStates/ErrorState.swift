//
//  ErrorState.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct ErrorState: View {
    let error: WeatherError
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 32))
                .foregroundColor(.red)
            
            VStack {
                Text(error.errorDescription)
                Text("Please try again.")
            }
            .font(.callout)
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
            .padding(.horizontal)
        }
        .padding()
        .background(AppColors.veryLightGrey)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

#Preview {
    ErrorState(error: .invalidResponse)
}
