//
//  TestView.swift
//  FluxStore
//
//  Created by Berker Saptas on 28.08.2023.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        HStack {
            Image(Icons.hamburgerMenu.rawValue)
            Spacer()
            Text("GemStore").font(.headline)
            Spacer()
            Image(systemName: "bell")
        }.padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
