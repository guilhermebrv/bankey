//
//  OnboardingContainerViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 07/02/2024.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
	func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
	let pageViewController: UIPageViewController
	var pages = [UIViewController]()
	var currentVC: UIViewController {
		didSet {
		}
	}
	weak var delegate: OnboardingContainerViewControllerDelegate?
	let closeButton = UIButton(type: .system)
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
		
		let page1 = OnboardingViewController(screenType: .screenOne)
		let page2 = OnboardingViewController(screenType: .screenTwo)
		let page3 = OnboardingViewController(screenType: .screenThree)
		
		pages.append(page1)
		pages.append(page2)
		pages.append(page3)
		
		currentVC = pages.first!
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupOnboarding()
		configButton()
	}
}

// MARK: - Onboarding setup and adding buttons
extension OnboardingContainerViewController {
	private func setupOnboarding() {
		view.backgroundColor = .secondarySystemBackground
		
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.didMove(toParent: self)
		
		pageViewController.dataSource = self
		pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
			view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
		])
		
		pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
	}
	
	private func configButton() {
		view.addSubview(closeButton)
		
		closeButton.translatesAutoresizingMaskIntoConstraints = false
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 18, weight: .medium)
		]
		let attributedTitle = NSAttributedString(string: "Close", attributes: titleAttributes)
		closeButton.setAttributedTitle(attributedTitle, for: .normal)
		closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .primaryActionTriggered)
		
		NSLayoutConstraint.activate([
			closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
			closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
		])
	}
}

// MARK: - Buttons Actions
extension OnboardingContainerViewController {
	@objc func tappedCloseButton(sender: UIButton) {
		delegate?.didFinishOnboarding()
	}
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return getPreviousViewController(from: viewController)
	}
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return getNextViewController(from: viewController)
	}
	private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
		currentVC = pages[index - 1]
		return pages[index - 1]
	}
	private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
		currentVC = pages[index + 1]
		return pages[index + 1]
	}
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return pages.count
	}
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return pages.firstIndex(of: self.currentVC) ?? 0
	}
}
