//
//  StatBox.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct StatBox: View {
    let title: String
    let value: String
    let width: CGFloat
    let size: CGFloat

    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.system(size: size))
                .foregroundColor(AppColors.lightGrey)
                .lineLimit(1)
            Text(value)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.darkGrey)
                .lineLimit(1)
        }
        .frame(width: width)
        .padding(16)
    }
}


#Preview {
    StatBox(title: "Feels Like", value: "5", width: 60, size: 8)
}

