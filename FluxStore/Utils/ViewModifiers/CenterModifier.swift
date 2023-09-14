//
//  CenterModifier.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import Foundation
import SwiftUI

struct CenterModifier : ViewModifier {
    func body(content: Content) -> some View{
        return content.frame(maxWidth: .infinity, alignment: .center)
    }
}
