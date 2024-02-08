//
//  Extension + UIViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 08/02/2024.
//

import UIKit

extension UIViewController {
	func setStatusBar() {
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithTransparentBackground()
		navBarAppearance.backgroundColor = .appColor
		UINavigationBar.appearance().standardAppearance = navBarAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
	}
	
	func setTabBarImage(imageName: String, title: String) {
		let config = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: imageName, withConfiguration: config)
		tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
	}
}
