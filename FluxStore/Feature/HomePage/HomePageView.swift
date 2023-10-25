//
//  HomePageView.swift
//  FluxStore
//
//  Created by Berker Saptas on 24.09.2023.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack {
            Color.clrBg.ignoresSafeArea()
            Text("Home Page View")
        } 
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
