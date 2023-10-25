//
//  WelcomeView.swift
//  FluxStore
//
//  Created by Berker Saptas on 25.08.2023.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var appStorageManager = AppStorageManager()
    
    @State private var showIntroView : Bool = false
    @State private var showSignUpView : Bool = false
    @State private var showHomePageView : Bool = false
    @State private var showLoginPageView : Bool = false
    
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(Images.welcome.rawValue).resizable()
                Color(.black).opacity(0.4)
                VStack {
                    Spacer()
                    Text("Welcome to GemStore")
                        .font(.title)
                    Text("The home for fashionista")
                        .font(.subheadline)
                        .padding(.top,20)
                    GetStartedButton(text: "Get Started", onTap: {
                        let introIsSeen : Bool = appStorageManager.readAppStorage(storageKey: .introIsSeen)
                        if introIsSeen {
                            
                            let email : String? = KeyChainStorage.getData(.getUserName)()
                            let password : String? = KeyChainStorage.getData(.getPassword)()
                            
                            if email != nil && password != nil {
                                NetworkManager.shared.login(email:email!, password: password! ){ result in
                                    switch result {
                                    case .success(let login):
                                        if(login.data != nil && login.data?.data != nil ) {
                                            showHomePageView = true
                                        }
                                    case .failure(let failer):
                                        showLoginPageView = true
                                        toast = Toast(type: .error, title: "Error", message: failer.localizedDescription)
                                    }
                                }
                            } else {
                                showSignUpView = true
                            }
                        } else {
                            showIntroView = true
                        }
                    }).padding(80)
                }.tint(.white)
                    .foregroundColor(.white)
            }.edgesIgnoringSafeArea(.all)
                .navigationDestination(isPresented: $showIntroView) {
                    IntroView()
                }
                .navigationDestination(isPresented: $showSignUpView) {
                    SignUpView()
                }
                .navigationDestination(isPresented: $showHomePageView) {
                    MainPageView()
                }
                .navigationDestination(isPresented: $showLoginPageView) {
                    LoginView()
                }
                .toastView(toast: $toast)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

