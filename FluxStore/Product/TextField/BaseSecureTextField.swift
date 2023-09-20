//
//  BaseSecureTextField.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import SwiftUI

struct BaseSecureTextField: View {
    var hintText : String
    var value : Binding<String>
    var contentType : UITextContentType?
    var isVisible : Binding<Bool>
    var isValidate : Binding<Bool>
        
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(hintText)
                    .font(.caption)
                    .foregroundColor(Color(.placeholderText))
                    .opacity(value.wrappedValue.isEmpty ? 0 : 1)
                    .offset(y: value.wrappedValue.isEmpty ? 20 : 0)
                ZStack{
                    SecureField(hintText, text: value)
                        .autocapitalization(.none).textContentType(contentType).opacity(isVisible.wrappedValue ? 0 : 1)
                    TextField(hintText, text: value)
                        .autocapitalization(.none).textContentType(contentType).opacity(isVisible.wrappedValue ? 1: 0)
                }
                Divider()
                    .frame(height: 1)
                    .background(isValidate.wrappedValue ? .red : ThemeManager().isDarkMode() ? .white :  .black)
            }.padding(.top,20)
            Button(action: {
                isVisible.wrappedValue.toggle()
            }) {
                Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill").foregroundColor(ThemeManager().isDarkMode() ? .gray : .black)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
