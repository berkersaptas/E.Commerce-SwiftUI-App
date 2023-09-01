//
//  TextFieldModifier.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import Foundation
import SwiftUI

/// View Modifier Example
struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View{
        return content.padding(10)
    }
}
