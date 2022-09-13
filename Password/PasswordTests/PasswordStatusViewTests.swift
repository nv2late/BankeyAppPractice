//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Reese on 2022/09/08.
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        // 🕹 Ready Player1
        // shoudlresetcriteria = false니까 포커스를 잃은 시점에선 false로 나와야 true인것
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        // 🕹 Ready Player1
        // false 값일때 criteria는 true가 나와야하니까 false
        // false 값일때 xmark가 보여야하니까 true
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
    }
}

class validateTests: XCTestCase {
    // 3개나 4개의 유효성을 확인
    // 3개이거나 4개일 때, true
    // 그 이하는 false
    // 4개 중 2개일 때 | 4개 중 3개일 때 | 4개 다 일때 함수테스트
    // validate 함수에 위에 변수 저장해서 테스팅하는데 two는 false, 34는 true
    var statusView: PasswordStatusView!
    let twoOfFour = "01234567A"
    let threeOfFour = "01234567Aa"
    let four = "01234567Aa@"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }
    
    func testFour() throws {
        XCTAssertTrue(statusView.validate(four))
    }
}
