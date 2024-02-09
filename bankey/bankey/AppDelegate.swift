//
//  AppDelegate.swift
//  bankey
//
//  Created by Guilherme Viana on 06/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	let loginViewController = LoginViewController()
	let onboardingContainerViewController = OnboardingContainerViewController()
	let dummyViewController = DummyViewController()
	let mainViewController = MainViewController()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemBackground
		window?.rootViewController = mainViewController
		
		loginViewController.delegate = self
		onboardingContainerViewController.delegate = self
		dummyViewController.delegate = self
		
		return true
	}
}

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, DummyViewControllerDelegate{
	func didLogout() {
		setRootViewController(loginViewController, animated: true)
	}
	
	func didFinishOnboarding() {
		setRootViewController(dummyViewController, animated: true)
		LocalState.hasOnboarded = true
	}
	
	func didLogin() {
		LocalState.hasOnboarded ? setRootViewController(mainViewController, animated: true) : setRootViewController(onboardingContainerViewController, animated: true)
	}
}

extension AppDelegate {
	func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
		guard animated, let window = self.window else {
			self.window?.rootViewController = vc
			self.window?.makeKeyAndVisible()
			return
		}

		window.rootViewController = vc
		window.makeKeyAndVisible()
		UIView.transition(with: window,
						  duration: 0.5,
						  options: .transitionCrossDissolve,
						  animations: nil,
						  completion: nil)
	}
}
