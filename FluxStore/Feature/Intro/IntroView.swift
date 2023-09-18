//
//  IntroView.swift
//  FluxStore
//
//  Created by Berker Saptas on 27.08.2023.
//

import SwiftUI

struct IntroView: View {
    
    @StateObject var appStorageManager = AppStorageManager()
    
    @State private var showLoginView : Bool = false
    @State private var tabViewIndex : Int = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack (alignment: .bottom){
                    Rectangle().frame(height: geometry.size.height / 2).foregroundColor(.regtangleBg)
                    VStack {
                        TabView(selection : $tabViewIndex) {
                            VStack {
                                Text("Discovery something new").font(.title).padding(.top,20)
                                Text("Special new arrivals just for you").font(.subheadline).padding(20)
                                Image(Images.intro1.rawValue)
                            }.tag(0)
                            VStack {
                                Text("Update trendy outfit").font(.title).padding(.top,20)
                                Text("Favorite brends and hottest trends").font(.subheadline).padding(20)
                                Image(Images.intro2.rawValue)
                            }.tag(1)
                            VStack {
                                Text("Explore your true style").font(.title).padding(.top,20)
                                Text("Relax and let us bring the style to you").font(.subheadline).padding(20)
                                Image(Images.intro3.rawValue)
                            }.tag(2)
                        }.tabViewStyle(.page)
                        GetStartedButton(text: "Shoping Now", onTap: {
                            appStorageManager.saveAppStorage(storageKey: .introIsSeen, value: true)
                            showLoginView = true                        }).opacity((tabViewIndex == 2) ? 1 :0).padding(.bottom,80)
                    }
                }.navigationBarBackButtonHidden(true)
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationDestination(isPresented: $showLoginView) {
                        SignUpView()
                    }
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
