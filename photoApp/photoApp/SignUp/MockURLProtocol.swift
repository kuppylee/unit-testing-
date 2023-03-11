//
//  MockURLProtocol.swift
//  photoApp
//
//  Created by Kuppylee on 13/02/2023.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?


    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if MockURLProtocol.error != nil {
            let errorDescription = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: [NSLocalizedDescriptionKey: "Localized error message"])
            client?.urlProtocol(self, didFailWithError: errorDescription)
        }else{
            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data() )
        }
        client?.urlProtocolDidFinishLoading(self)
        
       
//        if let signUpError = MockURLProtocol.error {
//            client?.urlProtocol(self, didFailWithError: signUpError)
//        } else {
//            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data() )
//        }
//            client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
}


