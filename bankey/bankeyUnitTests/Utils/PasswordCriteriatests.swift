//
//  PasswordCriteriatests.swift
//  bankeyUnitTests
//
//  Created by Guilherme Viana on 04/03/2024.
//

import XCTest
import Foundation

@testable import bankey

final class PasswordLengthCriteriatests: XCTestCase {
	func testShortPassword() throws {
		XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
	}
	
	func testLongPassword() throws {
		XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012gdrdas3jj3457890"))
	}
	
	func testValidShortPassword() throws {
		XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
	}
	
	func testValidLongPassword() throws {
		XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012"))
	}
		
	func testLengthAndNoSpaceMet() throws {
		XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("Testing!"))
	}
	
	func testLengthAndNoSpaceNotMet() throws {
		XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("Testing is gonna fail"))
	}
}

class PasswordSpaceCriteriatests: XCTestCase {
	func testNoSpaceMet() throws {
		XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("a"))
	}
	
	func testSpaceNotMet() throws {
		XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet(" "))
	}
}

class PasswordLettersCriteriatests: XCTestCase {
	func testUppercaseMet() throws {
		XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
	}
	
	func testUppercaseNotMet() throws {
		XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
	}
	
	func testLowercaseMet() throws {
		XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
	}
	
	func testLowercaseNotMet() throws {
		XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
	}
}

class PasswordDigitsCriteriatests: XCTestCase {
	func testDigitsMet() throws {
		XCTAssertTrue(PasswordCriteria.digitsMet("1"))
	}
	
	func testDigitsNotMet() throws {
		XCTAssertFalse(PasswordCriteria.digitsMet("a"))
	}
}

class PasswordSpecialCharactersCriteriatests: XCTestCase {
	func testSpecialCharactersMet() throws {
		XCTAssertTrue(PasswordCriteria.specialCharactersMet("!"))
	}
	
	func testSpecialCharactersNotMet() throws {
		XCTAssertFalse(PasswordCriteria.specialCharactersMet("a"))
	}
}
