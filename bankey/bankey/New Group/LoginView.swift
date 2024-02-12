//
//  LoginView.swift
//  bankey
//
//  Created by Guilherme Viana on 06/02/2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
	func signInTapped()
}

class LoginView: UIView {
	weak var delegate: LoginViewProtocol?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .black
		label.font = .systemFont(ofSize: 40, weight: .bold)
		label.numberOfLines = 0
		label.text = "Bankey"
		return label
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .systemGray
		label.font = .systemFont(ofSize: 20, weight: .medium)
		label.numberOfLines = 0
		label.text = "Your premium source for all things banking!"
		return label
	}()
	
	lazy var bgView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemBackground
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		return view
	}()
	
	lazy var usernameTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Username"
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		return textField
	}()
	
	lazy var dividerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemFill
		return view
	}()
	
	lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Password"
		textField.isSecureTextEntry = true
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		textField.enablePasswordToggle()
		textField.rightViewMode = .always
		return textField
	}()
	
	lazy var loginButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .filled()
		button.configuration?.imagePadding = 8
		button.configuration?.buttonSize = .large
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 20, weight: .bold)
		]
	   let attributedTitle = NSAttributedString(string: "Sign In", attributes: titleAttributes)
	   button.setAttributedTitle(attributedTitle, for: .normal)
		button.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
		return button
	}()
	
	lazy var errorMessageLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .systemRed
		label.numberOfLines = 0
		label.text = "Testing my alert"
		label.isHidden = true
		return label
	}()
}

extension LoginView {
	@objc public func signInTapped(sender: UIButton) {
		delegate?.signInTapped()
	}
}

extension LoginView {
	private func addElements() {
		addSubview(titleLabel)
		addSubview(descriptionLabel)
		addSubview(bgView)
		addSubview(usernameTextField)
		addSubview(dividerView)
		addSubview(passwordTextField)
		addSubview(loginButton)
		addSubview(errorMessageLabel)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			
			descriptionLabel.bottomAnchor.constraint(equalTo: bgView.topAnchor, constant: -30),
			descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			
			bgView.centerYAnchor.constraint(equalTo: centerYAnchor),
			bgView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: bgView.trailingAnchor, multiplier: 2),
			bgView.heightAnchor.constraint(equalToConstant: 78),
			
			usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: bgView.topAnchor, multiplier: 1),
			usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: bgView.leadingAnchor, multiplier: 1),
			bgView.trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 1),
			
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			dividerView.topAnchor.constraint(equalToSystemSpacingBelow: usernameTextField.bottomAnchor, multiplier: 1),
			dividerView.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
			
			passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
			passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
			passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 1),
			
			loginButton.topAnchor.constraint(equalToSystemSpacingBelow: bgView.bottomAnchor, multiplier: 2),
			loginButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
			loginButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
			
			errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
			errorMessageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}
