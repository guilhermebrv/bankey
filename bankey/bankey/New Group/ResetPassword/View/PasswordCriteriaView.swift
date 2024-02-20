//
//  PasswordCriteriaView.swift
//  bankey
//
//  Created by Guilherme Viana on 20/02/2024.
//

import UIKit

class PasswordCriteriaView: UIView {
	let stackView = UIStackView()
	var criteriaLabel = UILabel()
	let imageView = UIImageView()
	
	let circleImage = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
	let checkmarkImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
	let xmarkImage = UIImage(systemName: "xmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
	
	init(criteria: String) {
		super.init(frame: .zero)
		addElements()
		setupElements()
		configConstraints()
		criteriaLabel.text = criteria
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 200, height: 40)
	}
}

extension PasswordCriteriaView {
	private func addElements() {
		addSubview(stackView)
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(criteriaLabel)
	}
	
	private func setupElements() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
		 
		imageView.image = circleImage
		imageView.contentMode = .scaleAspectFit
		imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		
		criteriaLabel.font = .preferredFont(forTextStyle: .subheadline)
		criteriaLabel.textColor = .secondaryLabel
		criteriaLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		
		stackView.axis = .horizontal
		stackView.spacing = 8
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			
			imageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
			criteriaLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
		])
	}
}
