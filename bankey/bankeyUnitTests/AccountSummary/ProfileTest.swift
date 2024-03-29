//
//  ProfileTest.swift
//  bankeyUnitTests
//
//  Created by Guilherme Viana on 14/02/2024.
//

import Foundation
import XCTest

@testable import bankey

class ProfileTest: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	func testCanParse() throws {
		let json = """
		{
		"id": "1",
		"first_name": "Kevin",
		"last_name": "Flynn"
		}
		"""
		 
		let data = json.data(using: .utf8)!
		let result = try! JSONDecoder().decode(AccountProfileData.self, from: data)
		
		XCTAssertEqual(result.id, "1")
		XCTAssertEqual(result.firstName, "Kevin")
		XCTAssertEqual(result.lastName, "Flynn")
	}
}
