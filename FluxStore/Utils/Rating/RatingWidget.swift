//
//  RatingView.swift
//  FluxStore
//
//  Created by Berker Saptas on 12.11.2023.
//

import SwiftUI

struct RatingView: View {
    let rate : Double
    let totalRateScore : Int
    let count : Int
    
    var body: some View {
            HStack {
                ForEach((1...totalRateScore), id: \.self) {index in
                    Image(systemName: (Double(index) <= rate) ? RatingImage.fillStar.rawValue :
                            ( Double(index) - rate < 1) ? RatingImage.halfStar.rawValue :
                            RatingImage.emptyStar.rawValue ).foregroundStyle(.yellow)
                   }
                Text("(\(count.description))").foregroundStyle(.gray)
            }
  }
}

#Preview {
    RatingView(rate: 3.9, totalRateScore: 5, count: 120)
}
