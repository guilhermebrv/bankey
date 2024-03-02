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
	private var isCriteriaMet: Bool = true
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
		if sender === resetView.newPasswordTextField {
			setupNewPassword()
			_ = validate()
		} else if sender === resetView.renewPasswordTextField {
			if resetView.newPasswordTextField.text?.isEmpty == true {
				resetView.repasswordMessage.text = "Enter your password above"
				resetView.repasswordMessage.isHidden = false
			} else if resetView.newPasswordTextField.text != resetView.renewPasswordTextField.text {
				resetView.repasswordMessage.text = "Passwords do not match"
				resetView.repasswordMessage.isHidden = false
			} else {
				resetView.repasswordMessage.isHidden = true
			}
		}
	}
	func textFieldEditingChanged(_ sender: UITextField) {
		if sender === resetView.newPasswordTextField {
			isCriteriaMet = true
			clearError()
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
		
		if isCriteriaMet {
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
			
			guard let text, !text.isEmpty else {
				self.isCriteriaMet = false
				self.updateDisplay(text ?? "")
				return (false, "Enter your password")
			}
			
			let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+\\/-:;.,[]{}"
			let invalidChars = CharacterSet(charactersIn: validChars).inverted
			guard text.rangeOfCharacter(from: invalidChars) == nil else {
				self.isCriteriaMet = false
				self.updateDisplay(text)
				return (false, "Password contains invalid characters")
			}
			
			if text.count < 8 || text.count > 32 {
				self.isCriteriaMet = false
				self.updateDisplay(text)
				return (false, "Password must be between 8 and 32 characters")
			}
			
			if self.validateMinCriteria(text) {
				self.isCriteriaMet = true
				self.updateDisplay(text)
			} else {
				self.isCriteriaMet = false
				self.updateDisplay(text)
				return (false, "Password does not meet the minimum criteria")
			}
			
			return (true, "")
		}
		customValidation = newPasswordValidation
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
	private func validateMinCriteria(_ text: String) -> Bool {
		let uppercaseMet = PasswordCriteria.uppercaseMet(text)
		let lowercaseMet = PasswordCriteria.lowercaseMet(text)
		let digitsMet = PasswordCriteria.digitsMet(text)
		let specialCharactersMet = PasswordCriteria.specialCharactersMet(text)
		
		let checkable = [uppercaseMet, lowercaseMet, digitsMet, specialCharactersMet]
		let metCriteria = checkable.filter { $0 }
		
		return metCriteria.count >= 3
	}
}
