//
//  SignUpFormRequestModel.swift
//  photoApp
//
//  Created by Kuppylee on 11/02/2023.
//

import Foundation

struct SignUpFormRequestModel : Encodable{
    var name: String
    var email: String
    var password: String
}
