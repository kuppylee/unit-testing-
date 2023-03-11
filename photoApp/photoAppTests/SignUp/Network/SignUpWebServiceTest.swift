//
//  SignUpWebServiceTest.swift
//  photoAppTests
//
//  Created by Kuppylee on 10/02/2023.
//

import XCTest
@testable import photoApp

final class SignUpWebServiceTest: XCTestCase {
    
    var sut: SignUpWebService!
    var signUpFormRequestModel: SignUpFormRequestModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: sessionConfig)
        //        when you remove the urlSession from the sut it becomes an integration testing
         sut = SignUpWebService(urlString: SignUpConstants.signUpUrl, urlSession: urlSession)
        signUpFormRequestModel = SignUpFormRequestModel(name: "Mobolaji", email: "davidotty100000@gmail.com", password: "12345678")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signUpFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil 
    }
    
    func testSignUpWebService_whenGivenSuccessfulResponse_shouldReturnSuccess(){
        //Arrange
        var jsonString: String {
            var convertedJsonString : String?
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: [
                    "$id": "1",
                               "code": 0,
                               "message": "success",
                               "data": [
                               "$id": "2",
                               "Id": 7075,
                               "Name": "David",
                               "Email": "bjkuppy@gmail.com",
                               "Token": "3030401c-c5a5-43c8-8b73-2ab9e6f2ca22"
                       ]
                ], options: [])
                if let  jsonStringConverted = String(data: jsonData, encoding: .utf8){
                    convertedJsonString = jsonStringConverted
                }
            }
            catch{print(error)}
            
            return convertedJsonString!
        }
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "SignUp webservice response expectation")
        
        //Act
        sut.signUp(withForm: signUpFormRequestModel){ (signUpResponseModel, error) in
            //Assert
            XCTAssertEqual(signUpResponseModel?.data!.Name, "David")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 10)
    }
    
//    When an error takes place and the response is nil
    func testSignUpWebService_whenRecievedDifferentJSONResponse_ErrorTookPlace(){
        //Arrange
       
        var jsonString: String {
            var convertedJsonString : String?
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: [
                                "path": "users",
                                "error": "Internal Server Error",
//                                "data": nil
                ], options: [])
                if let  jsonStringConverted = String(data: jsonData, encoding: .utf8){
                    convertedJsonString = jsonStringConverted
                }
            }
            catch{print(error)}
            
            return convertedJsonString!
        }
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "SignUp() method expectation for a response that contains a different JSON structure")
        
        //Act
        sut.signUp(withForm: signUpFormRequestModel){ (signUpResponseModel, error) in
            //Assert
            XCTAssertNil(signUpResponseModel, "The response model for a request containing unknown json response should have been nill")
            XCTAssertEqual(error, SignUpError.invalidResponseModel, "SignUp() method did not return the expected error")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 10)
    }
    
    
    func testSignUpWebService_whenEmptyURLStringProvided_returnsError(){
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        sut = SignUpWebService(urlString: "")
        // Act
        sut.signUp(withForm: signUpFormRequestModel) { signUpResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignUpError.invalidRequestURLString, "SignUp() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signUpResponseModel, "When an invalidRequestURLStringError takes place, signUpResponseModel must be nil")
            expectation.fulfill()
        }
        // Assert
        self.wait(for: [expectation], timeout: 2)
        
    }
    
    func testSignUpWebservice_whenURLRequestFails_returnsErrorMessageDescription(){
        // Arrange
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDescription = "Localized error message"
       
        MockURLProtocol.error = SignUpError.failedRequest(description: errorDescription)
        // Act
        sut.signUp(withForm: signUpFormRequestModel) { signUpResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignUpError.failedRequest(description: errorDescription), "The signUp() method did not return an expected error for the failed request")
//            XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
        
    }
    
}
