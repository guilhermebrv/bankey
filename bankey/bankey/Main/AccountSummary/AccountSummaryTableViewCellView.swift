//
//  AccountSummaryTableViewCellView.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryTableViewCellView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var typeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Banking"
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		label.textColor = .black
		return label
	}()
	
	lazy var underlineView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .appColor
		return view
	}()
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "No-Fee All-In Chequing"
		label.textColor = .black
		label.font = .systemFont(ofSize: 15, weight: .medium)
		return label
	}()
	
	lazy var balanceStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()
	
	lazy var balanceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Current balance"
		label.textColor = .black
		label.font = .systemFont(ofSize: 12, weight: .medium)
		return label
	}()
	
	lazy var balanceAmountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "$17,562.44"
		label.textColor = .black
		label.font = .systemFont(ofSize: 25, weight: .medium)
		return label
	}()
	
	lazy var chevronImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "chevron.right")
		image.contentMode = .scaleAspectFit
		return image
	}()
}

extension AccountSummaryTableViewCellView {
	private func addElements() {
		addSubview(typeLabel)
		addSubview(underlineView)
		addSubview(nameLabel)
		addSubview(balanceStackView)
		balanceStackView.addArrangedSubview(balanceLabel)
		balanceStackView.addArrangedSubview(balanceAmountLabel)
		addSubview(chevronImageView)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			
			underlineView.heightAnchor.constraint(equalToConstant: 4),
			underlineView.widthAnchor.constraint(equalToConstant: 60),
			underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
			underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
			
			nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
			nameLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 12),
			
			chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			
			balanceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			balanceStackView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -15)
		])
	}
}
