//
//  photoAppTests.swift
//  photoAppTests
//
//  Created by Kuppylee on 09/02/2023.
//

import XCTest
@testable import photoApp

final class SignUpFormModelValidatorTest: XCTestCase {
    
    var sut: SignUpFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignUpFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testSignUpFormModelValidator_whenValidFirstNameProvided_shouldReturnTrue(){
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Seargie")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should return true but returned false")
    }
    
    func testSignUpFormModelValidator_whenTooShortFirstNameProvided_shouldReturnFalse(){
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        //Assert
        XCTAssertFalse(isFirstNameValid, "This function should return false in this instance of first name lesser than 2 character , but returns true")

    }
    
    func testSignUpFormModelValidator_whenTooLongFirstNameProvided_shouldReturnFalse(){
        //Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergySergyy")
        // Assert
        XCTAssertFalse(isFirstNameValid , "This function should return false in this instance of first name greater than 10 character, but returns true ")
    }
    
    func testSignUpFormModelValidator_whenValidLastNameProvided_shouldReturnTrue(){
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Kuppy")
        // Assert
        XCTAssertTrue(isLastNameValid, "This function should return true if the last name is valid, but it returned false")
    }
    
    func testSignUpFormModelValidator_whenTooShortLastNameProvided_shouldReturnFalse(){
        //Act
        let isLastNameValid = sut.isLastNameValid(lastName: "K")
        //Assert
        XCTAssertFalse(isLastNameValid, "This function should return false in this instance of last name lesser than 2 character , but returns true")
    }
    
    func testSignUpFormModelValidator_whenTooLongLastNameProvided_shouldReturnFalse(){
        //Act
        let isLastNameValid = sut.isLastNameValid(lastName: "KuppyKuppyy")
        //Assert
        XCTAssertFalse(isLastNameValid, "This function should return false in this instance of last name greater than 10 character, but returns true")
    }
    
    func testSignUpFormModelValidator_whenValidEmailProvided_shouldReturnTrue(){
        //Act
        let isEmailValid = sut.isEmailValid(email: "bjkuppy@gmail.com")
        //Assert
        XCTAssertTrue(isEmailValid, "This function should return true if the email is valid , but it returned false")
    }
    
    func testSignUpFormModelValidator_whenInvalidEmailProvided_shouldReturnFalse(){
        //Act
        let isEmailValid = sut.isEmailValid(email: "bjkuppy@gmailcom")
        //Assert
        XCTAssertFalse(isEmailValid, "This function should return false if the email is invalid , but it returned true")
    }
    
    func testSignUpFormModelValidator_whenMatchingPasswordIsProvided_shouldReturnTrue(){
        //Act
        let isPasswordMatching = sut.isPasswordMatching(password: "Kuppy", confirmPassword: "Kuppy")
        // Assert
        XCTAssertTrue(isPasswordMatching, "The expression should return a true if the password matches, but it returned false ")
    }
    
    func testSignUpFormModelValidator_whenNonMatchingPasswordIsProvided_shouldReturnFalse(){
        //Act
        let isPasswordMatching = sut.isPasswordMatching(password: "123456", confirmPassword: "12356")
        //Assert
        XCTAssertFalse(isPasswordMatching, "This expression should return false when non matching password are provided, but it returned true")
    }
    

}
