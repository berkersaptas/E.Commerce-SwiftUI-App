//
//  LoginView.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @State private var signUpClicked : Bool = false
    @State private var loginClicked : Bool = false
    
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State private var nameIsValidate : Bool = false
    @State private var emailIsValidate : Bool = false
    @State private var passwordIsValidate : Bool = false
    @State private var confirmPasswordIsValidate : Bool = false
    
    @State private var isVisiblePassword : Bool = false
    @State private var isVisibleConfirmPassword : Bool = false
    
    @State private var toast: Toast? = nil
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Create\nYour Account").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                BaseTextField( hintText: "Name", value:$name,contentType: .name,keyboardType: .default,isValidate: $nameIsValidate)
                BaseTextField(hintText: "Email address", value:$email,contentType: .emailAddress,keyboardType: .emailAddress,isValidate: $emailIsValidate)
                BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword,isValidate: $passwordIsValidate)
                BaseSecureTextField(hintText: "Confirm password", value:$confirmPassword,contentType: .password,isVisible: $isVisibleConfirmPassword,isValidate: $confirmPasswordIsValidate)
                PrimaryButton(text: "SIGN UP", onTap: {
                    if TextFieldValidation.name(name: name).validation() {
                        nameIsValidate = true
                        toast = TextFieldValidation.message(type: .name)
                        return
                    } else {
                        nameIsValidate = false
                    }
                    if TextFieldValidation.email(email: email).validation(){
                        emailIsValidate = true
                        toast = TextFieldValidation.message(type: .email)
                        return
                    } else {
                        emailIsValidate = false
                    }
                    if TextFieldValidation.password(password: password).validation(){
                        toast = TextFieldValidation.message(type: .password)
                        passwordIsValidate = true
                        return
                    } else {
                        passwordIsValidate = false
                    }
                    if TextFieldValidation.confirmPassword(password: password, confirmPassword: confirmPassword).validation(){
                        confirmPasswordIsValidate = true
                        toast = TextFieldValidation.message(type: .confirmPassword)
                        return
                    } else {
                        confirmPasswordIsValidate = false
                    }
                    NetworkManager.shared.setUser(name: name, email:email, password: password ){ result in
                        switch result {
                        case .success(let setUser):
                            if(setUser.data != nil && setUser.data?.data != nil ) {
                                signUpClicked = true
                            }
                        case .failure(let failer):
                            toast = Toast(type: .error, title: "Error", message: failer.localizedDescription)
                        }
                    }
                }).padding(.all)
                Text("or sign up with").foregroundColor(.gray)
                HStack(spacing: 20){
                    SocialIconWidget(icon:Icons.apple.rawValue)
                    SocialIconWidget(icon:Icons.google.rawValue).padding()
                    SocialIconWidget(icon:Icons.facebook.rawValue)
                }
                Spacer()
                Text("Already have accound [login](a)").environment(\.openURL, OpenURLAction(handler: { url in
                    //go to login page
                    loginClicked = true
                    return .discarded
                }))
            }
            .adaptsToKeyboard()
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $loginClicked) {
                LoginView()
            }
            .navigationDestination(isPresented: $signUpClicked) {
                LoginView()
            }
            .toastView(toast: $toast)
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
