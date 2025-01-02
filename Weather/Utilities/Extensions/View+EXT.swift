//
//  View+EXT.swift
//  Weather
//
//  Created by JC Manikis on 2025-01-01.
//

import SwiftUI

extension View {
    func keyboardDismissable() -> some View {
        self.modifier(KeyboardToolbarModifier())
    }
}

