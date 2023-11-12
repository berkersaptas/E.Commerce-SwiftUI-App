//
//  DefaultToolBar.swift
//  FluxStore
//
//  Created by Berker Saptas on 11.11.2023.
//

import SwiftUI

struct DefaultToolBar: View {

    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
            Spacer()
            Text("Gem Store").font(.headline)
            Spacer()
            Image(systemName: "bell.badge")
        }
    }
}

struct DefaultToolBar_Previews: PreviewProvider {
    static var previews: some View {
        DefaultToolBar()
    }
}
