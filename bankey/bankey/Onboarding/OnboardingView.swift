//
//  OnboardingView.swift
//  bankey
//
//  Created by Guilherme Viana on 07/02/2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
	func tappedCloseButton()
	func tappedNextButton()
	func tappedBackButton()
}

class OnboardingView: UIView {
	private weak var delegate: OnboardingViewProtocol?
	public func delegate(delegate: OnboardingViewProtocol) {
		self.delegate = delegate
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
	lazy var closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .plain()
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 20, weight: .medium)
		]
	   let attributedTitle = NSAttributedString(string: "Close", attributes: titleAttributes)
	   button.setAttributedTitle(attributedTitle, for: .normal)
	   button.addTarget(self, action: #selector(tappedCloseButton), for: .primaryActionTriggered)
	   return button
	}()
	
	lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.adjustsFontForContentSizeCategory = true
		label.font = .preferredFont(forTextStyle: .title3)
		label.textColor = .black
		label.numberOfLines = 0
		return label
	}()
	
	lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .plain()
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 20, weight: .medium)
		]
	   let attributedTitle = NSAttributedString(string: "Back", attributes: titleAttributes)
	   button.setAttributedTitle(attributedTitle, for: .normal)
	   button.addTarget(self, action: #selector(tappedBackButton), for: .primaryActionTriggered)
	   return button
	}()
	
	lazy var nextButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.configuration = .plain()
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 20, weight: .medium)
		]
	   let attributedTitle = NSAttributedString(string: "Next", attributes: titleAttributes)
	   button.setAttributedTitle(attributedTitle, for: .normal)
	   button.addTarget(self, action: #selector(tappedNextButton), for: .primaryActionTriggered)
	   return button
	}()
}

extension OnboardingView {
	@objc public func tappedBackButton(sender: UIButton) {
		delegate?.tappedBackButton()
	}
	@objc public func tappedCloseButton(sender: UIButton) {
		delegate?.tappedCloseButton()
	}
	@objc public func tappedNextButton(sender: UIButton) {
		delegate?.tappedNextButton()
	}
}

extension OnboardingView {
	private func addElements() {
		addSubview(closeButton)
		addSubview(stackView)
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(descriptionLabel)
		addSubview(backButton)
		addSubview(nextButton)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			closeButton.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
			closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			
			stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			
			
			backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
			backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			
			nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
			nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
		])
	}
}
