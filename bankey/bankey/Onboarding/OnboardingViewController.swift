//
//  OnboardingViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 07/02/2024.
//

import UIKit

enum ScreenType {
	case screenOne
	case screenTwo
	case screenThree
}

class OnboardingViewController: UIViewController {
	private let onboardingView: OnboardingView = OnboardingView()
	var screenType: ScreenType
	
	init(screenType: ScreenType) {
		self.screenType = screenType
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = onboardingView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configScreenType()
		signProtocols()
	}
}

extension OnboardingViewController {
	private func configScreenType() {
		switch screenType {
		case .screenOne:
		  onboardingView.imageView.image = UIImage(named: "delorean")
		  onboardingView.descriptionLabel.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
		  onboardingView.backButton.isHidden = true
		  break
		case .screenTwo:
		  onboardingView.imageView.image = UIImage(named: "thumbs")
		  break
		case .screenThree:
		  onboardingView.imageView.image = UIImage(named: "world")
		  onboardingView.nextButton.isHidden = true
		  break
		}
	}
	
	private func signProtocols() {
		onboardingView.delegate(delegate: self)
	}
}

extension OnboardingViewController: OnboardingViewProtocol {
	func tappedCloseButton() {
		print("tapped close")
		//
	}
	
	func tappedNextButton() {
		var next = UIViewController()
		switch screenType {
		case .screenOne:
			next = OnboardingViewController(screenType: .screenTwo)
		  break
		case .screenTwo:
			next = OnboardingViewController(screenType: .screenThree)
		  break
		case .screenThree:
		  break
		}
		navigationController?.pushViewController(next, animated: true)
	}
	
	func tappedBackButton() {
		navigationController?.popViewController(animated: true)
	}
}
