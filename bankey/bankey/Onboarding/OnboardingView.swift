//
//  OnboardingView.swift
//  bankey
//
//  Created by Guilherme Viana on 07/02/2024.
//

import UIKit

class OnboardingView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 25
		stackView.distribution = .equalCentering
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
}

extension OnboardingView {
	private func addElements() {
		addSubview(stackView)
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(descriptionLabel)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
		])
	}
}
