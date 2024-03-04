//
//  ResetPasswordView.swift
//  bankey
//
//  Created by Guilherme Viana on 18/02/2024.
//

import UIKit

protocol ResetPasswordViewDelegate: AnyObject {
	func textFieldEditingChanged(_ sender: UITextField)
	func textFieldEditingDidEnd(_ sender: UITextField)
	func resetButtonTapped()
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
		textField.attributedPlaceholder = NSAttributedString(string: "Enter new password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		textField.keyboardType = .asciiCapable
		textField.enablePasswordToggle()
		textField.addLockButton()
		textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
		textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
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
		label.text = "Your password must meet the requirements below"
		label.isHidden = true
		return label
	}()
	
	lazy var passwordCriteriaView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .tertiarySystemFill
		view.clipsToBounds = true
		view.layer.cornerRadius = 10
		return view
	}()
	
	lazy var passwordCriteriaStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .equalCentering
		stack.spacing = 8
		return stack
	}()
	
	lazy var criteriaView: PasswordCriteriaView = {
		let view = PasswordCriteriaView(criteria: "8-32 characters (no spaces)")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var criteriaLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .secondaryLabel
		label.numberOfLines = 2
		label.isHidden = false
		var boldAttribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline), NSAttributedString.Key.foregroundColor: UIColor.label]
		let regularAttribute = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
		let regularText1 = NSAttributedString(string: "Use at least", attributes: regularAttribute)
		let boldText = NSAttributedString(string: " 3 of these 4", attributes: boldAttribute)
		let regularText2 = NSAttributedString(string: " criteria when setting your password:", attributes: regularAttribute)
		let newString = NSMutableAttributedString()
		newString.append(regularText1)
		newString.append(boldText)
		newString.append(regularText2)
		label.attributedText = newString
		
		return label
	}()
	
	lazy var criteriaView2: PasswordCriteriaView = {
		let view = PasswordCriteriaView(criteria: "uppercase letter (A-Z)")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var criteriaView3: PasswordCriteriaView = {
		let view = PasswordCriteriaView(criteria: "lowercase (a-z)")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var criteriaView4: PasswordCriteriaView = {
		let view = PasswordCriteriaView(criteria: "digit (0-9)")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var criteriaView5: PasswordCriteriaView = {
		let view = PasswordCriteriaView(criteria: "special character (e.g. !@#$%^)")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var reenterPasswordView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemBackground
		return view
	}()
	
	lazy var renewPasswordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.attributedPlaceholder = NSAttributedString(string: "Re-enter new password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
		textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		textField.keyboardType = .asciiCapable
		textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
		textField.enablePasswordToggle()
		textField.addLockButton()
		return textField
	}()
	
	lazy var redividerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemFill
		return view
	}()
	
	lazy var repasswordMessage: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemRed
		label.numberOfLines = 0
		label.text = "Your password must meet the requirements above"
		label.isHidden = true
		return label
	}()
	
	lazy var resetButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .filled()
		button.setTitle("Reset password", for: [])
		button.configuration?.buttonSize = .large
		button.addTarget(self, action: #selector(resetButtonTapped), for: .primaryActionTriggered)
		button.isEnabled = false
		return button
	}()
	
	lazy var stackView1: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 10
		return stack
	}()
	
}

extension ResetPasswordView {
	@objc func textFieldEditingChanged(_ sender: UITextField) {
		delegate?.textFieldEditingChanged(sender)
	}
	@objc func textFieldEditingDidEnd(_ sender: UITextField) {
		delegate?.textFieldEditingDidEnd(sender)
	}
	@objc func resetButtonTapped() {
		delegate?.resetButtonTapped()
	}
}

extension ResetPasswordView {
	private func addElements() {
		addSubview(enterPasswordView)
		enterPasswordView.addSubview(newPasswordTextField)
		enterPasswordView.addSubview(dividerView)
		enterPasswordView.addSubview(passwordMessage)
		addSubview(passwordCriteriaView)
		passwordCriteriaView.addSubview(passwordCriteriaStackView)
		passwordCriteriaStackView.addArrangedSubview(criteriaView)
		passwordCriteriaStackView.addArrangedSubview(criteriaLabel)
		passwordCriteriaStackView.addArrangedSubview(criteriaView2)
		passwordCriteriaStackView.addArrangedSubview(criteriaView3)
		passwordCriteriaStackView.addArrangedSubview(criteriaView4)
		passwordCriteriaStackView.addArrangedSubview(criteriaView5)
		addSubview(reenterPasswordView)
		reenterPasswordView.addSubview(renewPasswordTextField)
		reenterPasswordView.addSubview(redividerView)
		reenterPasswordView.addSubview(repasswordMessage)
		stackView1.addArrangedSubview(enterPasswordView)
		stackView1.addArrangedSubview(passwordCriteriaView)
		stackView1.addArrangedSubview(reenterPasswordView)
		stackView1.addArrangedSubview(resetButton)
		addSubview(stackView1)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			stackView1.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView1.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			stackView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			
			enterPasswordView.leadingAnchor.constraint(equalTo: stackView1.leadingAnchor),
			enterPasswordView.trailingAnchor.constraint(equalTo: stackView1.trailingAnchor),
			enterPasswordView.heightAnchor.constraint(equalToConstant: 130),
			
			newPasswordTextField.topAnchor.constraint(equalTo: enterPasswordView.topAnchor, constant: 50),
			newPasswordTextField.leadingAnchor.constraint(equalTo: enterPasswordView.leadingAnchor),
			newPasswordTextField.trailingAnchor.constraint(equalTo: enterPasswordView.trailingAnchor),
			newPasswordTextField.heightAnchor.constraint(equalToConstant: 30),
			
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			dividerView.topAnchor.constraint(equalToSystemSpacingBelow: newPasswordTextField.bottomAnchor, multiplier: 1),
			dividerView.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
			
			passwordMessage.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 20),
			passwordMessage.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
			passwordMessage.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
			
			passwordCriteriaView.heightAnchor.constraint(equalToConstant: 215),
			passwordCriteriaView.leadingAnchor.constraint(equalTo: enterPasswordView.leadingAnchor),
			passwordCriteriaView.trailingAnchor.constraint(equalTo: enterPasswordView.trailingAnchor),
			
			passwordCriteriaStackView.leadingAnchor.constraint(equalTo: passwordCriteriaView.leadingAnchor, constant: 15),
			passwordCriteriaStackView.trailingAnchor.constraint(equalTo: passwordCriteriaView.trailingAnchor, constant: -20),
			passwordCriteriaStackView.topAnchor.constraint(equalTo: passwordCriteriaView.topAnchor, constant: 20),
			passwordCriteriaStackView.bottomAnchor.constraint(equalTo: passwordCriteriaView.bottomAnchor, constant: -15),
			
			reenterPasswordView.leadingAnchor.constraint(equalTo: enterPasswordView.leadingAnchor),
			reenterPasswordView.trailingAnchor.constraint(equalTo: enterPasswordView.trailingAnchor),
			reenterPasswordView.heightAnchor.constraint(equalToConstant: 90),
			
			renewPasswordTextField.topAnchor.constraint(equalTo: reenterPasswordView.topAnchor, constant: 10),
			renewPasswordTextField.leadingAnchor.constraint(equalTo: reenterPasswordView.leadingAnchor),
			renewPasswordTextField.trailingAnchor.constraint(equalTo: reenterPasswordView.trailingAnchor),
			renewPasswordTextField.heightAnchor.constraint(equalToConstant: 30),
			
			redividerView.heightAnchor.constraint(equalToConstant: 1),
			redividerView.topAnchor.constraint(equalToSystemSpacingBelow: renewPasswordTextField.bottomAnchor, multiplier: 1),
			redividerView.leadingAnchor.constraint(equalTo: renewPasswordTextField.leadingAnchor),
			redividerView.trailingAnchor.constraint(equalTo: renewPasswordTextField.trailingAnchor),
			
			repasswordMessage.topAnchor.constraint(equalTo: renewPasswordTextField.bottomAnchor, constant: 20),
			repasswordMessage.leadingAnchor.constraint(equalTo: renewPasswordTextField.leadingAnchor),
			repasswordMessage.trailingAnchor.constraint(equalTo: renewPasswordTextField.trailingAnchor),
		])
	}
}
