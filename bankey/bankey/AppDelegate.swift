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
	let mainViewController = MainViewController()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemBackground
		
		loginViewController.delegate = self
		onboardingContainerViewController.delegate = self
		
		registerForNotifications()
		
		displayLogin()
		return true
	}
}

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, DummyViewControllerDelegate{
	@objc func didLogout() {
		setRootViewController(loginViewController, animated: true)
	}
	
	func didFinishOnboarding() {
		LocalState.hasOnboarded = true
		prepMainView()
		setRootViewController(mainViewController, animated: true)
	}
	
	func didLogin() {
		displayNextScreen()
	}
	
	private func displayLogin() {
		setRootViewController(loginViewController)
	}
	
	private func displayNextScreen() {
		if LocalState.hasOnboarded {
			prepMainView()
			setRootViewController(mainViewController)
		} else {
			setRootViewController(onboardingContainerViewController)
		}
	}
	
	private func prepMainView() {
		mainViewController.setStatusBar()
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().backgroundColor = .appColor
	}
	
	private func registerForNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
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
