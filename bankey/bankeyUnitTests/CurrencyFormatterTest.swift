//
//  CurrencyFormatterTest.swift
//  bankeyUnitTests
//
//  Created by Guilherme Viana on 10/02/2024.
//

import Foundation
import XCTest

@testable import bankey

class Test: XCTestCase {
	var formatter: CurrencyFormatter!
	
	override func setUp() {
		super.setUp()
		formatter = CurrencyFormatter()
	}
	
	func testDollarsFormatted() throws {
		let result = formatter.dollarsFormatted(929466.23)
		XCTAssertEqual(result, "$929,466.23")
	}
	
	func testZeroDollarsFormatted() throws {
		let result = formatter.dollarsFormatted(0.00)
		XCTAssertEqual(result, "$0.00")
	}
}
