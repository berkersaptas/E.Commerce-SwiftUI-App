//
//  NetworkManager.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    struct ErrorResponse: Error {
        let status: String
        let errorModel : ErrorModel?
    }
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrorResponse>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel: nil)))
                return
            }
            
            guard let data = data else {
                //   completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                completion(.failure(ErrorResponse(status: "Invalid Response data", errorModel: nil)))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
        
                do{
                    let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)
                    completion(.failure(ErrorResponse(status: "Invalid Response", errorModel: decodedData)))
                    return
                }
                catch let error {
                    completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel:nil)))
                    return
                }
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch let error {
                // completion(.failure(error))
                completion(.failure(ErrorResponse(status: error.localizedDescription, errorModel: nil)))
            }
        }
        task.resume()
    }
    
    func setUser(name:String, email: String, password: String, completion: @escaping (Result<SetUserModel, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.setUser(name: name, email: email, password: password)
        request(endpoint, completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.login(email: email, password: password)
        request(endpoint, completion: completion)
    }
    
    func forgetPassword(email: String, completion: @escaping (Result<ForgetPasswordModel, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.forgetPassword(email: email)
        request(endpoint, completion: completion)
    }
    
    func resetPassword(email: String, password: String, completion: @escaping (Result<LoginModel, ErrorResponse>) -> Void) {
        let endpoint = Endpoint.resetPassword(email: email, password: password)
        request(endpoint, completion: completion)
    }
}
