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
	
	func addLockButton() {
		let lockbutton = UIButton(type: .custom)
		lockbutton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
		lockbutton.sizeToFit()
		lockbutton.frame = CGRect(x: 0, y: 0, width: lockbutton.frame.width, height: lockbutton.frame.height)

		
		let customView = UIView(frame: CGRect(x: 0, y: 0, width: lockbutton.frame.width + 10, height: lockbutton.frame.height))
		customView.addSubview(lockbutton)
		
		lockbutton.frame = CGRect(x: 0, y: 0, width: lockbutton.frame.width, height: lockbutton.frame.height)
		
		self.leftView = customView
		self.leftViewMode = .always
	}
	
	@objc func togglePasswordView(sender: UIButton) {
		isSecureTextEntry.toggle()
		sender.isSelected.toggle()
	}
}
