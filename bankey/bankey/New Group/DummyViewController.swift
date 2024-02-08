//
//  DummyViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 08/02/2024.
//

import UIKit

protocol DummyViewControllerDelegate: AnyObject {
	func didLogout()
}

class DummyViewController: UIViewController {
	weak var delegate: DummyViewControllerDelegate?
	
	private let dummyView: DummyView = DummyView()
	
	override func loadView() {
		view = dummyView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		dummyView.delegate = self
	}
}

extension DummyViewController: DummyViewDelegate {
	func tappedLogoutButton() {
		delegate?.didLogout()
	}
}
