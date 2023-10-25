//
//  ForgetPassword.swift
//  FluxStore
//
//  Created by Berker Saptas on 30.08.2023.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var email : String = ""
    @State private var continueClicked : Bool = false
    
    @State private var emailIsValidate : Bool = false
        
    @State private var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clrBg.ignoresSafeArea()
                VStack {
                    Text("Forget Password?").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                    Text("Enter email associated with your account and we’ll send and email with intructions to reset your password").font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
                    Spacer()
                    BaseTextField(hintText: "Enter your email here", value:$email,contentType: .emailAddress,keyboardType: .emailAddress,isValidate: $emailIsValidate)
                    Spacer()
                    PrimaryButton(text: "Continue", onTap: {
                        if TextFieldValidation.email(email: email).validation(){
                            emailIsValidate = true
                            toast = TextFieldValidation.message(type: .email)
                            return
                        } else {
                            emailIsValidate = false
                        }
                        NetworkManager.shared.forgetPassword(email:email){ result in
                            switch result {
                            case .success(let forgetPassword):
                                if(forgetPassword.data != nil && forgetPassword.data?.data != nil ) {
                                   //userEmail = email
                                    continueClicked = true
                                }
                            case .failure(let failer):
                                if failer.errorModel != nil {
                                toast = Toast(type: .error, title: "Error", message: failer.errorModel!.message!)
                                } else {
                                    toast = Toast(type: .error, title: "Error", message:failer.status)
                                }
                            }
                        }
                    }).padding()
                }.modifier(BasicToolBar(destination: AnyView(LoginView())))
                    .adaptsToKeyboard()
                    .padding()
                    .navigationDestination(isPresented: $continueClicked) {
                        VerificationCodeView(userEmail: email)
                    }
                .toastView(toast: $toast)
            }
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
