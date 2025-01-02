//
//  SeachBarView.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    let onSubmit: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            HStack {
                TextField("Search Location", text: $searchText)
                    .focused($isFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .onSubmit(onSubmit)
                    .submitLabel(.search)
                Group {
                    if !searchText.isEmpty {
                        Button {
                            withAnimation {
                                searchText = ""
                                onSubmit()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .frame(width: 17.5, height: 17.5)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        Image(.magnifyingGlassIcon)
                            .frame(width: 17.5, height: 17.5)
                    }
                }
                .foregroundStyle(AppColors.lightGrey)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 46)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppColors.veryLightGrey)
        }
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), onSubmit: {})
}
