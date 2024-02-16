//
//  ErrorAlert.swift
//  bankey
//
//  Created by Guilherme Viana on 16/02/2024.
//

import UIKit

class ErrorAlert {
	private let controller: UIViewController
	
	init(controller: UIViewController) {
		self.controller = controller
	}
	
	public func showAlert(title: String, message: String, confirm: @escaping () -> Void) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let confirmAction = UIAlertAction(title: "Ok", style: .default) { _ in
			confirm()
		}
		
		alertController.addAction(confirmAction)
		
		controller.present(alertController, animated: true)
	}
}
