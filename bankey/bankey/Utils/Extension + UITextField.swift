//
//  Extension + UITextField.swift
//  bankey
//
//  Created by Guilherme Viana on 12/02/2024.
//

import UIKit

extension UITextField {
	func enablePasswordToggle() {
		let passwordToggleButton = UIButton(type: .custom)

		passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
		passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
		passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		self.rightView = passwordToggleButton
		self.rightViewMode = .always
	}
	
	@objc func togglePasswordView(sender: UIButton) {
		isSecureTextEntry.toggle()
		sender.isSelected.toggle()
	}
}
