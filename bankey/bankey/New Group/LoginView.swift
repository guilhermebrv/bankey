//
//  LoginView.swift
//  bankey
//
//  Created by Guilherme Viana on 06/02/2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
	func signInTapped()
	func resetPasswordTapped()
}

class LoginView: UIView {
	weak var delegate: LoginViewProtocol?
	
	// Animation
	var leadingEdgeOnScreen: CGFloat = 16
	var leadingEdgeOffScreen: CGFloat = -1000
	var titleleadingAnchor: NSLayoutConstraint?
	var subtitleLeadingAnchor: NSLayoutConstraint?
	
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
		label.alpha = 0
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
		label.alpha = 0
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
		//textField.rightViewMode = .always
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
	
	lazy var forgotPasswordButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .plain()
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 20, weight: .medium)
		]
	   let attributedTitle = NSAttributedString(string: "Reset your password", attributes: titleAttributes)
	   button.setAttributedTitle(attributedTitle, for: .normal)
		button.addTarget(self, action: #selector(resetPasswordTapped), for: .primaryActionTriggered)
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
	@objc public func resetPasswordTapped(sender: UIButton) {
		delegate?.resetPasswordTapped()
	}
}

extension LoginView {
	public func animate() {
		let duration = 0.8
		
		let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
			self.titleleadingAnchor?.constant = self.leadingEdgeOnScreen
			self.layoutIfNeeded()
		}
		animator1.startAnimation()
		
		let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
			self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
			self.layoutIfNeeded()
		}
		animator2.startAnimation(afterDelay: 0.2)
		
		let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
			self.titleLabel.alpha = 1
			self.layoutIfNeeded()
		}
		animator3.startAnimation(afterDelay: 0.2)
		
		let animator4 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
			self.descriptionLabel.alpha = 1
			self.layoutIfNeeded()
		}
		animator4.startAnimation(afterDelay: 0.2)
	}
	
	public func shakeButton() {
		let animation = CAKeyframeAnimation()
		animation.keyPath = "position.x"
		animation.values = [0, 10, -10, 10, 0]
		animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
		animation.duration = 0.4
		
		animation.isAdditive = true
		loginButton.layer.add(animation, forKey: "shake")
	}
	
	private func addElements() {
		addSubview(titleLabel)
		addSubview(descriptionLabel)
		addSubview(bgView)
		addSubview(usernameTextField)
		addSubview(dividerView)
		addSubview(passwordTextField)
		addSubview(loginButton)
		addSubview(forgotPasswordButton)
		addSubview(errorMessageLabel)
	}
	
	private func configConstraints() {
		titleleadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingEdgeOffScreen)
		titleleadingAnchor?.isActive = true
		subtitleLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingEdgeOffScreen)
		subtitleLeadingAnchor?.isActive = true
		NSLayoutConstraint.activate([
			titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			descriptionLabel.bottomAnchor.constraint(equalTo: bgView.topAnchor, constant: -30),
			descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
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
			
			forgotPasswordButton.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
			forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: forgotPasswordButton.bottomAnchor, multiplier: 2),
			errorMessageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
		])
	}
}
