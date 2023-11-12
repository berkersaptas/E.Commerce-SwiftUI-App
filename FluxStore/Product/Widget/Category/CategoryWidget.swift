//
//  CategoryWidget.swift
//  FluxStore
//
//  Created by Berker Saptas on 11.11.2023.
//

import SwiftUI

struct CategoryWidget: View {
    let categoryName : String
    let isSelected : Bool
    let onTap : () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            if isSelected {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 3.0)
                        .foregroundColor(.black)
                        .frame(width: 50)
                        .overlay {
                            Circle().frame(width: 40)
                            Image(systemName: "option").foregroundColor(.white)
                        }
                }
            } else {
                ZStack {
                    Circle().frame(width: 50)
                        .foregroundColor(.gray)
                    Image(systemName: "option").foregroundColor(.white)
                }
            }
            Text(categoryName)
                .multilineTextAlignment(.center)
        }
        .onTapGesture {
            onTap()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryWidget(categoryName: "Demo asdasd asdasd asda sdasd", isSelected: true, onTap: {
            print("Demo Tapped")
        })
    }
}
