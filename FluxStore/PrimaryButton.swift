//
//  PrimaryButton.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import SwiftUI

struct PrimaryButton: View {
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
                   .foregroundColor(.black)
                   
            )  .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .stroke(.white, lineWidth: 2)
            )
       
        }
    }
    }
