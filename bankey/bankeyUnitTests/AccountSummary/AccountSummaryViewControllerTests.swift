//
//  AccountSummaryViewControllerTests.swift
//  bankeyUnitTests
//
//  Created by Guilherme Viana on 16/02/2024.
//

import Foundation
import XCTest

@testable import bankey

class AccountSummaryViewControllerTests: XCTestCase {
	var vc: AccountSummaryViewController!
	var mockService: MockAccountManager!
	
	class MockAccountManager: AccountManager {
		var account: AccountSummaryData?
		var error: NetworkError?
		
		func getProfileData(forUserId userId: String) async throws -> bankey.AccountProfileData {
			if let error = error {
				throw error
			}
			return bankey.AccountProfileData(id: "1", firstName: "FirstName", lastName: "LastName")
		}
		
		func getAccountData(forUserId userId: String) async throws -> [bankey.AccountSummaryData] {
			if let error = error {
				throw error
			}
			return [account!]
		}
	}
	
	override func setUp() {
		super.setUp()
		vc = AccountSummaryViewController()
		//vc.loadViewIfNeeded()
		
		mockService = MockAccountManager()
		
	}
	
	func testTitleAndMessageForInvalidURL() throws {
		let titleAndMessage = vc.titleAndMessageForTesting(for: .invalidURL)
		XCTAssertEqual("Error", titleAndMessage.0)
		XCTAssertEqual("The URL provided was invalid. Please try again later.", titleAndMessage.1)
	}
	
	func testTitleAndMessageForInvalidResponse() throws {
		let titleAndMessage = vc.titleAndMessageForTesting(for: .invalidResponse)
		XCTAssertEqual("Error", titleAndMessage.0)
		XCTAssertEqual("We received an invalid response from the server. Please ensure you are connected to the internet.", titleAndMessage.1)
	}
	
	func testTitleAndMessageForInvalidData() throws {
		let titleAndMessage = vc.titleAndMessageForTesting(for: .invalidData)
		XCTAssertEqual("Error", titleAndMessage.0)
		XCTAssertEqual("The data received from the server was invalid. Please try again later.", titleAndMessage.1)
	}
}
