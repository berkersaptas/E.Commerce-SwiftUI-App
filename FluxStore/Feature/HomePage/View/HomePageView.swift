//
//  HomePageView.swift
//  FluxStore
//
//  Created by Berker Saptas on 11.11.2023.
//

import SwiftUI

struct HomePageView: View {
    
    @ObservedObject var viewModel = HomePageViewModel()
    
    @State var selectedCategory : String?
    
    var body: some View {
        ZStack {
            Color.clrBg.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    DefaultToolBar()
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.categories,id: \.self) { category in
                                CategoryWidget(categoryName: category, isSelected: selectedCategory == category) {
                                    //category select - ignore selected value repeat
                                    if(selectedCategory != category){
                                        selectedCategory = category
                                    } else {
                                        selectedCategory = nil
                                    }
                                }
                            }.padding(.vertical,4)
                        }
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(viewModel.products,id: \.id) { product in
                            Text(product.title)
                        }
                    }
                }
            }
        }.padding()
            .onAppear {
                viewModel.fetchCategoriesData()
                viewModel.fetchProductsData()
            }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
