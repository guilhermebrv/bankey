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
		if sender == resetView.newPasswordTextField {
			if PasswordCriteria.lengthCriteriaMet(sender.text ?? "") && PasswordCriteria.noSpaceCriteriaMet(sender.text ?? "") {
				resetView.criteriaView.imageView.image = resetView.criteriaView.checkmarkImage ?? UIImage()
			} else {
				resetView.criteriaView.imageView.image = resetView.criteriaView.xmarkImage ?? UIImage()
			}
		}
	}
}

struct PasswordCriteria {
	static func lengthCriteriaMet(_ text: String) -> Bool {
		return text.count >= 8 && text.count <= 32
	}
	static func noSpaceCriteriaMet(_ text: String) -> Bool {
		return !text.contains(" ")
	}
}


//var isCriteriaMet: Bool = false {
//	didSet {
//		imageView.image = isCriteriaMet? checkmarkImage : xmarkImage
//	}
//}

//func reset() {
//	isCriteriamet = false
//	imageView.image = circleImage
//}
