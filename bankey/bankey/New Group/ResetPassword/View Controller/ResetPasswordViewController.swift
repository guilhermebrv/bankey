//
//  ResetPasswordViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 18/02/2024.
//

import UIKit

class ResetPasswordViewController: UIViewController {
	
	private let resetView: ResetPasswordView = ResetPasswordView()
	
	override func loadView() {
		view = resetView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
    }
    
}
