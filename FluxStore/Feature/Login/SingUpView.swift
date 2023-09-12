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
    
    @State var isVisiblePassword : Bool = false
    @State var isVisibleConfirmPassword : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Create\nYour Account").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                TextFormView { validate  in
                    VStack {
                        BaseTextField( hintText: "Name", value:$name,contentType: .name,keyboardType: .default) {
                            !(name.isEmpty) && (name.count >= 2)
                        }
                        BaseTextField(hintText: "Email address", value:$email,contentType: .emailAddress,keyboardType: .emailAddress) {
                            !(email.isEmpty)
                        }
                        BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword) {
                            !(password.isEmpty)
                        }
                        BaseSecureTextField(hintText: "Confirm password", value:$confirmPassword,contentType: .password,isVisible: $isVisibleConfirmPassword) {
                            !(confirmPassword.isEmpty) && (password == confirmPassword)
                        }
                        PrimaryButton(text: "SIGN UP", onTap: {
                            if !validate() {
                                return
                            }
                            signUpClicked = true
                        }).padding()
                    }
                }
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


