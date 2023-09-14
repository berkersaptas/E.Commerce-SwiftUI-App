//
//  GetStartedButton.swift
//  FluxStore
//
//  Created by Berker Saptas on 26.08.2023.
//

import SwiftUI

struct GetStartedButton: View {
    var text : String
    var onTap : () -> Void
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Text(text)
                .foregroundColor(.white)
                .padding()
                .background(
                    Rectangle()
                        .cornerRadius(60)
                        .foregroundColor(.gray)
                    
                )  .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(.white, lineWidth: 2)
                )
        }
    }
}
