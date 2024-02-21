//
//  ResetPasswordViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 18/02/2024.
//

import UIKit

protocol ResetPasswordViewControllerDelegate: AnyObject {
	func textFieldEditingChanged1(_ sender: UIButton)
}

class ResetPasswordViewController: UIViewController {
	
	private let resetView: ResetPasswordView = ResetPasswordView()
	private var shouldResetCriteria: Bool = true
	
	override func loadView() {
		view = resetView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		signProtocols()
    }
    
}

extension ResetPasswordViewController {
	private func signProtocols() {
		resetView.delegate = self
		resetView.newPasswordTextField.delegate = self
		resetView.renewPasswordTextField.delegate = self
	}
}

extension ResetPasswordViewController: ResetPasswordViewDelegate, UITextFieldDelegate {
	func textFieldEditingChanged(_ sender: UITextField) {
		if sender === resetView.newPasswordTextField {
			updateDisplay(sender.text ?? "")
		}
	}
}

extension ResetPasswordViewController {
	private func updateDisplay(_ text: String) {
		let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
		let uppercaseMet = PasswordCriteria.uppercaseMet(text)
		let lowercaseMet = PasswordCriteria.lowercaseMet(text)
		let digitsMet = PasswordCriteria.digitsMet(text)
		let specialCharactersMet = PasswordCriteria.specialCharactersMet(text)
		
		if shouldResetCriteria {
			resetView.criteriaView.imageView.image = lengthAndNoSpaceMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.circleImage
			resetView.criteriaView2.imageView.image = uppercaseMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.circleImage
			resetView.criteriaView3.imageView.image = lowercaseMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.circleImage
			resetView.criteriaView4.imageView.image = digitsMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.circleImage
			resetView.criteriaView5.imageView.image = specialCharactersMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.circleImage
		}
	}
}

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
