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
    var isValidate : Binding<Bool>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(hintText)
                .font(.caption)
                .foregroundColor(Color(.placeholderText))
                .opacity(value.wrappedValue.isEmpty ? 0 : 1)
                .offset(y: value.wrappedValue.isEmpty ? 20 : 0)
            TextField(hintText, text: value).autocapitalization(.none).textContentType(contentType).keyboardType(keyboardType)
            Divider()
                .frame(height: 1)
                .background(isValidate.wrappedValue ? .red : ThemeManager().isDarkMode() ? .white :  .black)
        }.padding(.top,20)
    }
}

