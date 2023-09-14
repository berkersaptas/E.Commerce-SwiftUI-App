//
//  LoginView.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var signUpClicked : Bool = false
    @State var loginClicked : Bool = false
    @State var forgetPasswordClicked : Bool = false
    
    @State var emailIsValidate : Bool = false
    @State var passwordIsValidate : Bool = false
    
    @State var email : String = ""
    @State var password : String = ""
    
    @State var isVisiblePassword : Bool = false
    
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
                        return
                    } else {
                        emailIsValidate = false
                    }
                    if(password.isEmpty) {
                        passwordIsValidate = true
                        return
                    } else {
                        passwordIsValidate = false
                    }
                    loginClicked = true
                }).padding()
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
            }.padding().navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $forgetPasswordClicked) {
                    ForgetPasswordView()
                }.navigationDestination(isPresented: $loginClicked) {
                    //TODO : Home Page Navigation
                    TestView()
                }
                .navigationDestination(isPresented: $signUpClicked) {
                    SignUpView()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}
