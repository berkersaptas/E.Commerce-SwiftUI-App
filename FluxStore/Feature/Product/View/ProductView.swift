//
//  ProductView.swift
//  FluxStore
//
//  Created by Berker Saptas on 12.11.2023.
//

import SwiftUI

struct ProductView: View {
    let product : ProductItemModel
    var body: some View {
        ZStack {
            Color(.clrBg)
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                        .frame(width: 120, height: 150)
                } placeholder: {
                    ProgressView()
                }
                Text(product.title)
                    .multilineTextAlignment(.center)
                Text("$ \(product.price.description)").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                RatingWidget(rate: product.rating.rate, count: product.rating.count)
                    .frame(width: 100)
            } .padding()
                .scaledToFit()
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    ProductView(product: ProductItemModel(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 3.9, count: 120)))
}

/*
 Image(systemName: "star.fill").foregroundColor(.yellow)
 Image(systemName: "star").foregroundColor(.yellow)
 Image(systemName: "star.leadinghalf.filled").foregroundColor(.yellow)
 */
