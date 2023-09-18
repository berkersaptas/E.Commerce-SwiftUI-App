//
//  CreateNewPassword.swift
//  FluxStore
//
//  Created by Berker Saptas on 9.09.2023.
//

import SwiftUI

struct CreateNewPasswordView: View {
    
    var userEmail : String?
    
    @State private var browseHomeClicked = false
    @State private var openSheet: Bool = false
    
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State private var isVisiblePassword : Bool = false
    @State private var isVisibleConfirmPassword : Bool = false
    
    @State private var passwordIsValidate : Bool = false
    @State private var confirmPasswordIsValidate : Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create new password").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                Text("Your new password must be different from previously used password").font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
                    .padding(.vertical)
                VStack {
                    BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword,isValidate: $passwordIsValidate)
                    BaseSecureTextField(hintText: "Confirm password", value:$confirmPassword,contentType: .password,isVisible: $isVisibleConfirmPassword,isValidate: $confirmPasswordIsValidate)
                    Spacer()
                    PrimaryButton(text: "Confirm", onTap: {
                        if !(!password.isEmpty && password.count >= 6){
                            passwordIsValidate = true
                            toast = Toast(type: .warning, title: "Warning", message: "Password field cannot be left blank and must contain at least six characters")
                            return
                        } else {
                            passwordIsValidate = false
                        }
                        if !(password == confirmPassword){
                            confirmPasswordIsValidate = true
                            toast = Toast(type: .warning, title: "Warning", message: "Password and confirm password fields do not contain the same values")
                            return
                        } else {
                            confirmPasswordIsValidate = false
                        }
                        if userEmail == nil {
                            toast = Toast(type: .warning, title: "Warning", message: "Email Errpr")
                            return
                        }
                        NetworkManager.shared.resetPassword(email:userEmail!, password: password ){ result in
                            switch result {
                            case .success(let resetPassword):
                                if(resetPassword.data != nil && resetPassword.data?.data != nil ) {
                                    openSheet = true
                                }
                            case .failure(let failer):
                                toast = Toast(type: .error, title: "Error", message: failer.localizedDescription)
                            }
                        }
                        //openSheet = true
                    })
                }
                .sheet(isPresented: $openSheet) {
                    Image(Icons.success.rawValue)
                    Text("Your password has been changed").bold().padding()
                    Text("Welcome back! Discover now!").foregroundColor(.gray)
                        .presentationDetents([.medium, .large])
                        .presentationCornerRadius(40)
                    PrimaryButton(text: "Browse home", onTap: {
                        browseHomeClicked = true
                    }).padding()
                }
            }
            .adaptsToKeyboard()
            .padding()
            .navigationDestination(isPresented: $browseHomeClicked) {
                LoginView()
            }
            .modifier(BasicToolBar(destination: AnyView(ForgetPasswordView())))
            .toastView(toast: $toast)
        }
    }
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}

