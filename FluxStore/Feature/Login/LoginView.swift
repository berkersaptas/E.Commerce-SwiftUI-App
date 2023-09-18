//
//  LoginView.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var signUpClicked : Bool = false
    @State private var loginClicked : Bool = false
    @State private var forgetPasswordClicked : Bool = false
    
    @State private var emailIsValidate : Bool = false
    @State private var passwordIsValidate : Bool = false
    
    @State private var email : String = ""
    @State private var password : String = ""
    
    @State private var isVisiblePassword : Bool = false
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Log into\nYour Account").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                BaseTextField(hintText: "Email address", value:$email,contentType: .emailAddress,keyboardType: .emailAddress,isValidate: $emailIsValidate)
                BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword,isValidate: $passwordIsValidate)
                Text("Forget password").foregroundColor(.gray).frame(maxWidth: .infinity, alignment: .trailing).onTapGesture {
                    forgetPasswordClicked = true
                }.padding(.vertical,20)
                PrimaryButton(text: "LOG IN", onTap: {
                    if(email.isEmpty){
                        emailIsValidate = true
                        toast = Toast(type: .warning, title: "Warning", message: "Email field cannot be left blank")
                        return
                    } else {
                        emailIsValidate = false
                    }
                    if(password.isEmpty) {
                        passwordIsValidate = true
                        toast = Toast(type: .warning, title: "Warning", message: "Password field cannot be left blank")
                        return
                    } else {
                        passwordIsValidate = false
                    }
                    NetworkManager.shared.login(email:email, password: password ){ result in
                        switch result {
                        case .success(let login):
                            if(login.data != nil && login.data?.data != nil ) {
                                var setKeyChainMail :Bool =  KeyChainStorage.setData(.setUserName(userName: email))()
                                var setKeyChainPassword :Bool =  KeyChainStorage.setData(.setPassword(password: password))()
                                if(setKeyChainMail && setKeyChainPassword) {
                                    loginClicked = true
                                }
                                else {
                                    toast = Toast(type: .warning, title: "Warning", message: "An error occurred while registering")
                                }
                            }
                        case .failure(let failer):
                            toast = Toast(type: .error, title: "Error", message: failer.localizedDescription)
                        }
                    }
                })
                .padding()
                Text("or log in with").foregroundColor(.gray).padding()
                HStack(){
                    SocialIconWidget(icon: Icons.apple.rawValue)
                    SocialIconWidget(icon:Icons.google.rawValue).padding()
                    SocialIconWidget(icon:Icons.facebook.rawValue)
                }
                Spacer()
                Text("Don't have accound [Sing Up](a)").environment(\.openURL, OpenURLAction(handler: { url in
                    signUpClicked = true
                    return .discarded
                }))
            }.adaptsToKeyboard()
                .padding().navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $forgetPasswordClicked) {
                    ForgetPasswordView()
                }
                .navigationDestination(isPresented: $loginClicked) {
                    //TODO : Home Page Navigation
                    HomePage()
                }
                .navigationDestination(isPresented: $signUpClicked) {
                    SignUpView()
                }
                .toastView(toast: $toast)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}
