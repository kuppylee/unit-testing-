//
//  SignUpResponseModel.swift
//  photoApp
//
//  Created by Kuppylee on 11/02/2023.
//

import Foundation

struct SignUpResponseModel : Codable {
    let code: Int
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let Id: Int
    let Name, Email, Token: String
}
