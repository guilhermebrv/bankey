//
//  ResetPasswordView.swift
//  bankey
//
//  Created by Guilherme Viana on 18/02/2024.
//

import UIKit

protocol ResetPasswordViewDelegate: AnyObject {
	
}

class ResetPasswordView: UIView {
	
	weak var delegate: ResetPasswordViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var newPasswordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "New password"
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		textField.enablePasswordToggle()
		textField.addLockButton()
		return textField
	}()
	
	lazy var dividerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemFill
		return view
	}()
	
	lazy var passwordMessage: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemRed
		label.numberOfLines = 0
		label.text = "Enter your password."
		return label
	}()
	
}

extension ResetPasswordView {
	private func addElements() {
		addSubview(newPasswordTextField)
		addSubview(dividerView)
		addSubview(passwordMessage)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			newPasswordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 40),
			newPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			newPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			newPasswordTextField.heightAnchor.constraint(equalToConstant: 20),
			
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			dividerView.topAnchor.constraint(equalToSystemSpacingBelow: newPasswordTextField.bottomAnchor, multiplier: 1),
			dividerView.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
			
			passwordMessage.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 20),
			passwordMessage.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			passwordMessage.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor)
		])
	}
}
