//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Reese on 2022/09/08.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    // Boundary conditions 8-32
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }
    
    // 33
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567890abcdefjhikpoaasdnxlwnnsd"))
    }
    
    // 8
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }
    
    // 32
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890ab"))
    }
}

class PasswordOthercriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
    
    func testUppercase() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("ABC"))
    }
    
    func testNotUppercase() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("abc"))
    }
    
    func testLowercase() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("abc"))
    }
    
    func testNotLowercase() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("ABC"))
    }
    
    func testDigit() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("1234"))
    }
    
    func testNotDigit() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("abc"))
    }
    
    func testSpChar() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("$$#%@!"))
    }
    
    func testNotSpChar() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("slbkd"))
    }
}
