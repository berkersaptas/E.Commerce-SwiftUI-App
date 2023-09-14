//
//  BasicToolBar.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import SwiftUI

struct BasicToolBar : ViewModifier {
    var destination : AnyView
    func body(content: Content) -> some View{
        return content.navigationBarBackButtonHidden(true).toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: destination) {
                    Image(Icons.backButton.rawValue)
                }
            }
        }
    }
}
