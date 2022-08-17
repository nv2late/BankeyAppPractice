//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Reese on 2022/08/15.
//

import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!

    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }

    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }

    func testBreakZeroDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(0.00)
        XCTAssertEqual(result.0, "0")
        XCTAssertEqual(result.1, "00")
    }

    // Challenge: You write
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
        let currencySymbol = locale.currencySymbol!
        print("\(currencySymbol)")

        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
    }
}
