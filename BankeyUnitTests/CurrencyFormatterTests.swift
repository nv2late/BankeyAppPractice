//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Reese on 2022/08/15.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    // Challange
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
    
    func testDollarsFormattedWithCurrencySymbol() throws {
        let locale = Locale.current
        print("\(locale)")
        let currenySymbol = locale.currencySymbol!
        print("\(currenySymbol)")
        
        let result = formatter.dollarsFormatted(0.00)
        print("\(result)")
        //XCTAssertEqual(result, "\(currenySymbol)0.00")
    }
}
