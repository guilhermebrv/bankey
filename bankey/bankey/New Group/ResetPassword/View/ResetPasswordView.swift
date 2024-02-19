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
	
	lazy var enterPasswordView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemBackground
		return view
	}()
	
	lazy var newPasswordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.attributedPlaceholder = NSAttributedString(string: "New password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		textField.keyboardType = .asciiCapable
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
		label.isHidden = false
		return label
	}()
	
	lazy var stackView1: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 20
		return stack
	}()
	
}

extension ResetPasswordView {
	private func addElements() {
		addSubview(enterPasswordView)
		enterPasswordView.addSubview(newPasswordTextField)
		enterPasswordView.addSubview(dividerView)
		enterPasswordView.addSubview(passwordMessage)
		stackView1.addArrangedSubview(enterPasswordView)
		addSubview(stackView1)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			enterPasswordView.topAnchor.constraint(equalTo: stackView1.topAnchor),
			enterPasswordView.leadingAnchor.constraint(equalTo: stackView1.leadingAnchor),
			enterPasswordView.trailingAnchor.constraint(equalTo: stackView1.trailingAnchor),
			enterPasswordView.heightAnchor.constraint(equalToConstant: 150),
			
			newPasswordTextField.topAnchor.constraint(equalTo: enterPasswordView.topAnchor, constant: 50),
			newPasswordTextField.leadingAnchor.constraint(equalTo: enterPasswordView.leadingAnchor, constant: 30),
			newPasswordTextField.trailingAnchor.constraint(equalTo: enterPasswordView.trailingAnchor, constant: -30),
			newPasswordTextField.heightAnchor.constraint(equalToConstant: 20),
			
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			dividerView.topAnchor.constraint(equalToSystemSpacingBelow: newPasswordTextField.bottomAnchor, multiplier: 1),
			dividerView.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
			
			passwordMessage.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 20),
			passwordMessage.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			passwordMessage.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
			
			stackView1.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView1.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView1.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
