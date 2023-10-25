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
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return "http://127.0.0.1:6000"
    }
    
    var path: String {
        switch self {
        case .setUser: return "/setUser"
        case .login : return "/login"
        case .forgetPassword : return "/forgetPassword"
        case .resetPassword : return "/resetPassword"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .setUser: return .post
        case .login: return .post
        case .forgetPassword: return .post
        case .resetPassword: return .post
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



