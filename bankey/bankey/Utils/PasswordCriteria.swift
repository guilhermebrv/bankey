//
//  PasswordCriteria.swift
//  bankey
//
//  Created by Guilherme Viana on 21/02/2024.
//

import Foundation

struct PasswordCriteria {
	static func lengthAndNoSpaceMet(_ text: String) -> Bool {
		return lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
	}
	static func lengthCriteriaMet(_ text: String) -> Bool {
		return text.count >= 8 && text.count <= 32
	}
	static func noSpaceCriteriaMet(_ text: String) -> Bool {
		return !text.contains(" ")
	}
	static func uppercaseMet(_ text: String) -> Bool {
		return text.range(of: "[A-Z]+", options: .regularExpression) != nil
	}
	static func lowercaseMet(_ text: String) -> Bool {
		return text.range(of: "[a-z]+", options: .regularExpression) != nil
	}
	static func digitsMet(_ text: String) -> Bool {
		return text.range(of: "[0-9]+", options: .regularExpression) != nil
	}
	static func specialCharactersMet(_ text: String) -> Bool {
		return text.range(of: "[\\W]+", options: .regularExpression) != nil
	}
}
