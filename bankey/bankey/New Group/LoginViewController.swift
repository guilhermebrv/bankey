//
//  LoginViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 06/02/2024.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
	func didLogin()
}

class LoginViewController: UIViewController {
	private let loginView: LoginView = LoginView()
	weak var delegate: LoginViewControllerDelegate?
	
	override func loadView() {
		view = loginView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		signProtocols()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		loginView.usernameTextField.text = ""
		loginView.passwordTextField.text = ""
		loginView.loginButton.configuration?.showsActivityIndicator = false
		loginView.errorMessageLabel.text = ""
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		loginView.animate()
	}
}

extension LoginViewController {
	private func signProtocols() {
		loginView.delegate = self
		loginView.usernameTextField.delegate = self
		loginView.passwordTextField.delegate = self
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
	}
}

extension LoginViewController: LoginViewProtocol {	
	func signInTapped() {
		login()
	}
	
	private func login() {
		guard let username = loginView.usernameTextField.text, let password = loginView.passwordTextField.text else {
			loginView.shakeButton()
			assertionFailure("Username or password should never be nil")
			return
		}
		
		if username.isEmpty || password.isEmpty {
			loginView.shakeButton()
			showMessage(message: "Username / Password should not be empty")
			return
		}
		
		if username == "Guilherme" && password == "123" {
			loginView.loginButton.configuration?.showsActivityIndicator = true
			delegate?.didLogin()
		} else {
			loginView.shakeButton()
			showMessage(message: "Username / Password is incorrect")
		}
	}
	
	private func showMessage(message: String) {
		loginView.errorMessageLabel.text = message
		loginView.errorMessageLabel.isHidden = false
	}
}
