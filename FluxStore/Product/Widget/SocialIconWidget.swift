//
//  SocialIconView.swift
//  FluxStore
//
//  Created by Berker Saptas on 29.08.2023.
//

import SwiftUI

struct SocialIconWidget : View {
   @State var showingAlert : Bool = false
   let icon : String
   var body: some View {
       ZStack {
           Circle()
               .stroke(.gray, lineWidth: 2)
               .frame(width: 40, height: 40)
           Image(icon)
       } .onTapGesture {
           showingAlert = true
       }.alert("Feature In Development", isPresented: $showingAlert) {
           Button("OK", role: .cancel) { }
       }
   }
}
