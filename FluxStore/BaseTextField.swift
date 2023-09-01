//
//  BaseTextField.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import SwiftUI

struct BaseTextField: View {
    var hintText : String
    var value : Binding<String>
    var contentType : UITextContentType?
    var keyboardType : UIKeyboardType
    var validateFlag : () -> Bool
    
    var body: some View {
        VStack {
            TextField(hintText, text: value).validate {
                validateFlag()
            }.textContentType(contentType).keyboardType(keyboardType)
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(value.wrappedValue.isEmpty ? .black : validateFlag() ? .green : .red)
        }.padding(.top,20)
    }
}
