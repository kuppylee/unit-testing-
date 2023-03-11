//
//  SignUpError.swift
//  photoApp
//
//  Created by Kuppylee on 11/02/2023.
//

import Foundation

enum SignUpError : LocalizedError, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description : String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description) :
            return description
        case .invalidRequestURLString, .invalidResponseModel :
            return ""
        }
    }
}
