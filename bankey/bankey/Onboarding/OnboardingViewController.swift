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
	}
}

extension OnboardingViewController {
	private func configScreenType() {
		switch screenType {
		case .screenOne:
		  onboardingView.imageView.image = UIImage(named: "delorean")
		  onboardingView.descriptionLabel.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
		  break
		case .screenTwo:
		  onboardingView.imageView.image = UIImage(named: "thumbs")
		  onboardingView.descriptionLabel.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
		  break
		case .screenThree:
		  onboardingView.imageView.image = UIImage(named: "world")
	      onboardingView.descriptionLabel.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."
		  break
		}
	}
}
