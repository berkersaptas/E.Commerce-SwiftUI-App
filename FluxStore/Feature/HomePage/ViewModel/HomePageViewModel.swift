//
//  HomePageViewModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 12.11.2023.
//

import Foundation


import SwiftUI

class HomePageViewModel: ObservableObject{
    
    @Published var categories: [String] = [] {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    @Published var products: [ProductItemModel] = [] {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    func fetchCategoriesData(){
        NetworkManager.shared.getCategories{ result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.categories = response
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchProductsData(){
        NetworkManager.shared.getProducts{ result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    } 
    func fetchCategoryProduct(categoryName : String){
        NetworkManager.shared.getCategory(categoryName: categoryName) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
