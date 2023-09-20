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
    
    struct ErrorResponse: Codable {
        let status: String
        let data: Dictionary<String, String?>
        let errors: Dictionary<String, [String]>
    }
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: (response as? HTTPURLResponse)!.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch let error {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func setUser(name:String, email: String, password: String, completion: @escaping (Result<SetUserModel, Error>) -> Void) {
        let endpoint = Endpoint.setUser(name: name, email: email, password: password)
        request(endpoint, completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        let endpoint = Endpoint.login(email: email, password: password)
        request(endpoint, completion: completion)
    }
    
    func forgetPassword(email: String, completion: @escaping (Result<ForgetPasswordModel, Error>) -> Void) {
        let endpoint = Endpoint.forgetPassword(email: email)
        request(endpoint, completion: completion)
    }
    
    func resetPassword(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        let endpoint = Endpoint.resetPassword(email: email, password: password)
        request(endpoint, completion: completion)
    }
    
    /*
     // Tum endpintler buradan kontrol ediyoruz.
     func getUser(completion: @escaping (Result<[User], Error>) -> Void) {
     let endpoint = Endpoint.getUsers
     request(endpoint, completion: completion)
     }
     
     func getComments(postID: String, completion: @escaping (Result<CommentArray, Error>) -> Void) {
     let endpoint = Endpoint.comments(postID: postID)
     request(endpoint, completion: completion)
     }
     
     
     */
}
