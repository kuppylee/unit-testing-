//
//  SignUpWebService.swift
//  photoApp
//
//  Created by Kuppylee on 10/02/2023.
//

import Foundation


class SignUpWebService  {
    
    private var urlString: String
    // inject URLSession
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUp(withForm formModel: SignUpFormRequestModel, completionHandler : @escaping (SignUpResponseModel?, SignUpError?) -> Void ){
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignUpError.invalidRequestURLString)
            return
        }
        // preparing the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        // sending the request
        let dataTask = urlSession.dataTask(with: request) { data, response , error in
            
            if let requestError = error {
                completionHandler(nil, SignUpError.failedRequest(description: requestError.localizedDescription))
                return
            }
            if let data = data, let signUpResponse = try? JSONDecoder().decode(SignUpResponseModel.self, from: data) {
                    completionHandler(signUpResponse, nil )
                } else {
                    completionHandler(nil, SignUpError.invalidResponseModel)
                }
        }
        dataTask.resume()
    }
}
