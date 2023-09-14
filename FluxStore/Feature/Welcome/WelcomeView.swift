//
//  WelcomeView.swift
//  FluxStore
//
//  Created by Berker Saptas on 25.08.2023.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showIntroView : Bool = false

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
                        showIntroView = true
                    }).padding(80)
                }.tint(.white)
                    .foregroundColor(.white)
            }.edgesIgnoringSafeArea(.all)
                .navigationDestination(isPresented: $showIntroView) {
                    IntroView()
                }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
        
    }
}

