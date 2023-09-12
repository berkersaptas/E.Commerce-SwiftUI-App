//
//  CreateNewPassword.swift
//  FluxStore
//
//  Created by Berker Saptas on 9.09.2023.
//

import SwiftUI

struct CreateNewPasswordView: View {
    
    @State var browseHomeClicked = false
    @State private var openSheet: Bool = false
    
    @State var password : String = ""
    @State var confirmPassword : String = ""
    
    @State var isVisiblePassword : Bool = false
    @State var isVisibleConfirmPassword : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create new password").font(.title).frame(maxWidth: .infinity, alignment: .leading)
                Text("Your new password must be different from previously used password").font(.subheadline).frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
                    .padding(.vertical)
                TextFormView  { validate  in
                    VStack {
                        BaseSecureTextField(hintText: "Password", value:$password,contentType: .newPassword,isVisible: $isVisiblePassword) {
                            !(password.isEmpty)
                        }
                        BaseSecureTextField(hintText: "Confirm password", value:$confirmPassword,contentType: .password,isVisible: $isVisibleConfirmPassword) {
                            !(confirmPassword.isEmpty) && (password == confirmPassword)
                        }
                        Spacer()
                        PrimaryButton(text: "Confirm", onTap: {
                            print(validate())
                            if !validate() {
                                return
                            }
                            openSheet = true
                        })
                    }
                    .sheet(isPresented: $openSheet) {
                        VStack {
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
                }
            }
            .padding().navigationDestination(isPresented: $browseHomeClicked) {
                LoginView()
            }.modifier(BasicToolBar(destination: AnyView(ForgetPasswordView())))
            
        }
    }
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}


