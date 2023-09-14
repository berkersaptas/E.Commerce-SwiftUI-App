//
//  ForgetPassword.swift
//  FluxStore
//
//  Created by Berker Saptas on 30.08.2023.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State var email : String = ""
    @State var continueClicked : Bool = false
    
    @State var emailIsValidate : Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Forget Password?").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                Text("Enter email associated with your account and we’ll send and email with intructions to reset your password").font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
                    Spacer()
                    BaseTextField(hintText: "Enter your email here", value:$email,contentType: .emailAddress,keyboardType: .emailAddress,isValidate: $emailIsValidate)
                    Spacer()
                    PrimaryButton(text: "Continue", onTap: {
                        if(email.isEmpty){
                            emailIsValidate = true
                            return
                        } else {
                            emailIsValidate = false
                        }
                        continueClicked = true
                    }).padding()
                
            }.modifier(BasicToolBar(destination: AnyView(LoginView())))
                .padding().navigationDestination(isPresented: $continueClicked) {
                    VerificationCodeView()
                }
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
