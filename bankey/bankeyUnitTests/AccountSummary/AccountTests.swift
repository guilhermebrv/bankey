//
//  AccountTests.swift
//  bankeyUnitTests
//
//  Created by Guilherme Viana on 14/02/2024.
//

import XCTest

@testable import bankey

class AccountTests: XCTestCase {

    override func setUp() {
		super.setUp()
    }

    func testCanParse() throws {
		let json = """
		[
			{
			  "id": "1",
			  "type": "Banking",
			  "name": "Basic Savings",
			  "amount": 100.00,
			  "createdDateTime" : "2010-06-21T15:29:32Z"
			},
			{
			  "id": "2",
			  "type": "Banking",
			  "name": "All-In Chequing",
			  "amount": 200.00,
			  "createdDateTime" : "2011-06-21T15:29:32Z"
			}
		]
		"""
		 
		let data = json.data(using: .utf8)!
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		let result = try! decoder.decode([AccountSummaryData].self, from: data)
		
		XCTAssertEqual(result[0].id, "1")
		XCTAssertEqual(result[0].name, "Basic Savings")
		XCTAssertEqual(result[0].type, .Banking)
		XCTAssertEqual(result[0].amount, 100.00)
		XCTAssertEqual(result[0].createdDateTime?.monthDayYearString, "Jun 21, 2010")
		
		XCTAssertEqual(result[1].id, "2")
		XCTAssertEqual(result[1].name, "All-In Chequing")
		XCTAssertEqual(result[1].type, .Banking)
		XCTAssertEqual(result[1].amount, 200.00)
		XCTAssertEqual(result[1].createdDateTime?.monthDayYearString, "Jun 21, 2011")
    }

}
