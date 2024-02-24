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
	typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
	var customValidation: CustomValidation?
	
	var text: String? {
		get { return resetView.newPasswordTextField.text }
		set { resetView.newPasswordTextField.text = newValue }
	}
	
	override func loadView() {
		view = resetView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		signProtocols()
		dismissKeyBoard()
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
	func textFieldEditingDidEnd(_ sender: UITextField) {
		setupNewPassword()
	}
	func textFieldEditingChanged(_ sender: UITextField) {
		if sender === resetView.newPasswordTextField {
			updateDisplay(sender.text ?? "")
		}
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return true
	}
}

extension ResetPasswordViewController {
	private func dismissKeyBoard() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
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
		} else {
			resetView.criteriaView.imageView.image = lengthAndNoSpaceMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.xmarkImage
			resetView.criteriaView2.imageView.image = uppercaseMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.xmarkImage
			resetView.criteriaView3.imageView.image = lowercaseMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.xmarkImage
			resetView.criteriaView4.imageView.image = digitsMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.xmarkImage
			resetView.criteriaView5.imageView.image = specialCharactersMet ? PasswordCriteriaView.checkmarkImage : PasswordCriteriaView.xmarkImage
		}
	}
	private func setupNewPassword() {
		let newPasswordValidation: CustomValidation = { text in
			
		guard let text = text, !text.isEmpty else {
			self.shouldResetCriteria = false
			self.updateDisplay(text ?? "")
			return (false, "Enter your password")
		}
		
		let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+\\/-:;.,[]"
		let invalidChars = CharacterSet(charactersIn: validChars).inverted
		guard text.rangeOfCharacter(from: invalidChars) == nil else {
			self.shouldResetCriteria = false
			self.updateDisplay(text)
			return (false, "Password contains invalid characters")
		}
		
		self.shouldResetCriteria = true
		self.updateDisplay(text)
		return (true, "")
		}
	}
	private func setupConfirmPassword() {
		let confirmPasswordValidation: CustomValidation = { text in
			guard let text = text, !text.isEmpty else {
				return (false, "Enter your password")
			}
			
			guard text == self.resetView.newPasswordTextField.text else {
				return (false, "Passwords do not match")
			}
			return (true, "")
		}
	}
}

extension ResetPasswordViewController {
	private func validate() -> Bool {
		if let customValidation = customValidation, let customValidationResult = customValidation(text), customValidationResult.0 == false {
			showError(customValidationResult.1)
			return false
		}
		clearError()
		return true
	}
	private func showError(_ message: String) {
		resetView.passwordMessage.text = message
		resetView.passwordMessage.isHidden = false
	}
	private func clearError() {
		resetView.passwordMessage.isHidden = true
		resetView.passwordMessage.text = ""
	}
}
