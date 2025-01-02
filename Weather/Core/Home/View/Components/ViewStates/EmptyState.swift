//
//  EmptyState.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 15) {
            Group {
                Text("No City Selected")
                    .font(.system(size: 30))
                
                Text("Please Search For a City")
                    .font(.system(size: 15))
            }
            .fontWeight(.semibold)
            .foregroundColor(AppColors.veryDarkGrey)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
