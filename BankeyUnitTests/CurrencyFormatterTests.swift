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
    let customCurrency = "$"
    let customLocale = "en_US"
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter(withCustomLocale: customLocale, withCurrency: customCurrency)
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDecimalAndFraction(929466.23)
        let currencyWithDecimal = result.0
        let fraction = result.1
        
        XCTAssertEqual(currencyWithDecimal, "929,466")
        XCTAssertEqual(fraction, "23")
    }
    
    // Challange
    func testCurrencyFormatted() throws {
        let result = formatter.formatCurrency(929466.23)
        XCTAssertEqual(result, "\(customCurrency)929,466.23")
    }
    
    func testZeroCurrencyFormatted() throws {
        let result = formatter.formatCurrency(0)
        XCTAssertEqual(result, "\(customCurrency)0.00")
    }
}
