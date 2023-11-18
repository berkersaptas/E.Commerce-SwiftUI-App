//
//  RatingWidget.swift
//  FluxStore
//
//  Created by Berker Saptas on 12.11.2023.
//

import SwiftUI

struct RatingWidget: View {
    let rate : Double
    let count : Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach((1...5), id: \.self) {index in
                Image(systemName: (Double(index) <= rate) ? RatingImage.fillStar.rawValue :
                        ( Double(index) - rate < 1) ? RatingImage.halfStar.rawValue :
                        RatingImage.emptyStar.rawValue ).foregroundStyle(.yellow)
            }
            Text("(\(count.description))").foregroundStyle(.gray)
        }
        .fixedSize()
    }
}

#Preview {
    RatingWidget(rate: 3.9, count: 120)
}
