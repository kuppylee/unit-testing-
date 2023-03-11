//
//  SignUpFormModelValidator.swift
//  photoApp
//
//  Created by Kuppylee on 09/02/2023.
//

import Foundation


class SignUpFormModelValidator {
    
    func isFirstNameValid(firstName: String) -> Bool{
        var returnValue = true
        if firstName.isEmpty || firstName.count < SignUpConstants.firstNameMinLength || firstName.count > SignUpConstants.firstNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        if lastName.isEmpty || lastName.count < SignUpConstants.lastNameMinLength || lastName.count > SignUpConstants.lastNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func isEmailValid(email: String) -> Bool{
        var returnValue = true
        if !email.isEmpty{
            if email.contains("@") && email.contains(".") {
                return returnValue
            }else{
                returnValue = false
            }
        } else{
            returnValue = false
        }
        return returnValue
    }
    
    func isPasswordMatching(password: String , confirmPassword: String) -> Bool {
        
        var returnValue = true
        if password.isEmpty || confirmPassword.isEmpty {
            returnValue = false
        } else{
            if password != confirmPassword {
                returnValue = false
            }
        }
        return returnValue
    }
}
