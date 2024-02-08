//
//  DummyView.swift
//  bankey
//
//  Created by Guilherme Viana on 08/02/2024.
//

import UIKit

protocol DummyViewDelegate: AnyObject {
	func tappedLogoutButton()
}

class DummyView: UIView {
	
	weak var delegate: DummyViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var logoutButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		let titleAttributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 18, weight: .medium)
		]
		let attributedTitle = NSAttributedString(string: "Logout", attributes: titleAttributes)
		button.setAttributedTitle(attributedTitle, for: .normal)
		button.addTarget(self, action: #selector(tappedLogoutButton), for: .primaryActionTriggered)
		return button
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .black
		label.font = .systemFont(ofSize: 40, weight: .bold)
		label.text = "Welcome"
		return label
	}()

	lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 20
		return stackView
	}()
}

extension DummyView {
	@objc func tappedLogoutButton() {
		delegate?.tappedLogoutButton()
	}
}

extension DummyView {
	private func addElements() {
		addSubview(logoutButton)
		addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			logoutButton.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: logoutButton.trailingAnchor, multiplier: 2),
			
			stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
		])
	}
}
