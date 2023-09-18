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
                    if !(!name.isEmpty && name.count >= 2){
                        nameIsValidate = true
                        toast = Toast(type: .warning, title: "Warning", message: "Name field cannot be left blank and must contain at least two characters")
                        return
                    } else {
                        nameIsValidate = false
                    }
                    if !(!email.isEmpty && name.count >= 2){
                        emailIsValidate = true
                        toast = Toast(type: .warning, title: "Warning", message: "Email field cannot be left blank and must contain at least two characters")
                        return
                    } else {
                        emailIsValidate = false
                    }
                    if !(!password.isEmpty && password.count >= 6){
                        toast = Toast(type: .warning, title: "Warning", message: "Password field cannot be left blank and must contain at least six characters")
                        passwordIsValidate = true
                        return
                    } else {
                        passwordIsValidate = false
                    }
                    if !(confirmPassword == password){
                        confirmPasswordIsValidate = true
                        toast = Toast(type: .warning, title: "Warning", message: "Password and confirm password fields do not contain the same values")
                        return
                    } else {
                        confirmPasswordIsValidate = false
                    }
                    //Request Service Create Account
                    NetworkManager.shared.setUser(name: name, email:email, password: password ){ result in
                        switch result {
                        case .success(let setUser):
                            if(setUser.data != nil && setUser.data?.data != nil ) {
                                /*
                                 toast = Toast(type: .success, title: "Success", message: "Successfully registered")
                                 */
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
           .navigationBarBackButtonHidden(true)  .navigationDestination(isPresented: $signUpClicked) {
                LoginView()
            }
            .navigationDestination(isPresented: $loginClicked) {
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
