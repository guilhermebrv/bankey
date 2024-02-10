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
		
//		let statusBarSize = UIApplication.shared.statusBarFrame.size
//		let frame = CGRect(origin: .zero, size: statusBarSize)
//		let statusBarView = UIView(frame: .zero)
//		
//		statusBarView.backgroundColor = .appColor
//		view.addSubview(statusBarView)
	}
	
	func setTabBarImage(imageName: String, title: String) {
		let config = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: imageName, withConfiguration: config)
		tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
	}
}
