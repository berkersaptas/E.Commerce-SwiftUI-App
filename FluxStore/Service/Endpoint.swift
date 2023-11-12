//
//  Endpoint.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint {
    case setUser(name: String, email: String, password: String)
    case login(email: String, password: String)
    case forgetPassword(email: String)
    case resetPassword(email: String, password: String)
    case getCategories
    case getCategory(categoryName : String)
    case getProducts
    case getProduct(productId : String)
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        switch self {
        case .setUser:
            return "http://127.0.0.1:6000"
        case .login :
            return "http://127.0.0.1:6000"
        case .forgetPassword:
            return "http://127.0.0.1:6000"
        case .resetPassword:
            return "http://127.0.0.1:6000"
        case .getCategories:
            return "https://fakestoreapi.com"
        case .getCategory:
            return "https://fakestoreapi.com"
        case .getProducts:
            return "https://fakestoreapi.com"
        case .getProduct:
            return "https://fakestoreapi.com"
        }
        
    }
    
    var path: String {
        switch self {
        case .setUser: return "/setUser"
        case .login : return "/login"
        case .forgetPassword : return "/forgetPassword"
        case .resetPassword : return "/resetPassword"
        case .getCategories : return "/products/categories"
        case .getCategory(categoryName: let categoryName) : return "products/category/\(categoryName)"
        case .getProducts : return "/products"
        case .getProduct(productId: let productId) : return "products/\(productId)"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .setUser: return .post
        case .login: return .post
        case .forgetPassword: return .post
        case .resetPassword: return .post
        case .getCategories: return .get
        case .getCategory: return .get
        case .getProducts: return .get
        case .getProduct: return .get
        }
    }
    
    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    var parameters: [String : Any]? {
        
        if case .setUser(let name, let email, let password) = self {
            return ["name": name, "email": email, "password": password]
        }
        
        if case .login(let email, let password) = self {
            return ["email": email, "password": password]
        }
        
        if case .forgetPassword(let email) = self {
            return ["email": email]
        }
        
        if case .resetPassword(let email, let password) = self {
            return ["email": email,"password": password]
        }
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }
        
        //Add Path
        components.path = path
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        //Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}



