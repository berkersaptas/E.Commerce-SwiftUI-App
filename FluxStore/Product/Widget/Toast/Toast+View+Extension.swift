//
//  Toast+View+Extension.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import Foundation
import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))

    }
}
