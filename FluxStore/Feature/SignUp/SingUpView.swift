//
//  LoginView.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State var signUpClicked : Bool = false
    @State var loginClicked : Bool = false
    
    @State var name : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var confirmPassword : String = ""
    
    @State var nameIsValidate : Bool = false
    @State var emailIsValidate : Bool = false
    @State var passwordIsValidate : Bool = false
    @State var confirmPasswordIsValidate : Bool = false
    
    @State var isVisiblePassword : Bool = false
    @State var isVisibleConfirmPassword : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Create\nYour Account").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                BaseTextField( hintText: "Name", value:$name,contentType: .name,keyboardType: .default,isValidate: $nameIsValidate)
                BaseTextField(hintText: "Email address", value:$email,contentType: .emailAddress,keyboardType: .emailAddress,isValidate: $emailIsValidate)
                BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword,isValidate: $passwordIsValidate)
                BaseSecureTextField(hintText: "Confirm password", value:$confirmPassword,contentType: .password,isVisible: $isVisibleConfirmPassword,isValidate: $confirmPasswordIsValidate)
                PrimaryButton(text: "SIGN UP", onTap: {
                    if !(!name.isEmpty && name.count >= 2){
                        nameIsValidate = true
                        return
                    } else {
                        nameIsValidate = false
                    }
                    if !(!email.isEmpty && name.count >= 2){
                        emailIsValidate = true
                        return
                    } else {
                        emailIsValidate = false
                    }
                    if !(!password.isEmpty && password.count >= 6){
                        passwordIsValidate = true
                        return
                    } else {
                        passwordIsValidate = false
                    }
                    if !(confirmPassword == password){
                        confirmPasswordIsValidate = true
                        return
                    } else {
                        confirmPasswordIsValidate = false
                    }
                    //Request Service Create Account
                    signUpClicked = true
                }).padding()
                Text("or sign up with").foregroundColor(.gray)
                HStack(spacing: 20){
                    SocialIconWidget(icon: Icons.apple.rawValue)
                    SocialIconWidget(icon:Icons.google.rawValue).padding()
                    SocialIconWidget(icon:Icons.facebook.rawValue)
                }
                Spacer()
                Text("Already have accound [login](a)").environment(\.openURL, OpenURLAction(handler: { url in
                    //go to login page
                    loginClicked = true
                    return .discarded
                }))
            }.padding().navigationBarBackButtonHidden(true)  .navigationDestination(isPresented: $signUpClicked) {
                LoginView()
            }
            .navigationDestination(isPresented: $loginClicked) {
                LoginView()
            }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
