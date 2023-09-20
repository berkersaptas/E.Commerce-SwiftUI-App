//
//  TextFieldValidation.swift
//  FluxStore
//
//  Created by Berker Saptas on 19.09.2023.
//

import Foundation


protocol TextFieldValidationProtocol {
    func validation() -> Bool
}

enum TextFieldValidation {
    case name (name : String)
    case email (email : String)
    case password (password : String)
    case confirmPassword (password : String, confirmPassword : String)
}

enum TextFieldValidationType {
    case name
    case email
    case password
    case confirmPassword
}


extension TextFieldValidation : TextFieldValidationProtocol {
    
   static func message(type : TextFieldValidationType ) -> Toast {
        switch type{
        case .name : return Toast(type: .warning, title: "Warning", message: "Name field cannot be left blank and must contain at least two characters")
        case .email: return Toast(type: .warning, title: "Warning", message: "Email field cannot be left blank and must contain at least two characters")
        case .password:  return Toast(type: .warning, title: "Warning", message: "Password field cannot be left blank and must contain at least six characters")
        case .confirmPassword:  return Toast (type: .warning, title: "Warning", message: "Password and confirm password fields do not contain the same values")
        }
    }
    
    func validation() -> Bool {
        switch self {
        case .name(let name):
            return !(!name.isEmpty && name.count >= 2)
        case .email(let email):
            return !(!email.isEmpty && email.count >= 2)
        case .password(let password):
            return !(!password.isEmpty && password.count >= 6)
        case .confirmPassword(let password, let confirmPassword):
            return !(confirmPassword == password)
        }
    }
}
