//
//  AccountSummaryTableViewCell.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryTableViewCell: UITableViewCell {
	
	static let identifier: String = String(describing: AccountSummaryTableViewCell.self)
	private var cellView: AccountSummaryTableViewCellView = AccountSummaryTableViewCellView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configScreen()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configScreen() {
		contentView.addSubview(cellView)
		cellView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
			cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}
	
	public func setupCell(with summaryData: AccountSummaryData?) {
		cellView.balanceAmountLabel.attributedText = summaryData?.balanceAsAttributtedString
		cellView.nameLabel.text = summaryData?.accountName
		cellView.typeLabel.text = summaryData?.accountType?.rawValue
		
		switch summaryData?.accountType {
		case .Banking:
			cellView.underlineView.backgroundColor = .appColor
			cellView.balanceLabel.text = "Current balance"
		case .CreditCard:
			cellView.underlineView.backgroundColor = .systemOrange
			cellView.balanceLabel.text = "Balance"
		case .Investment:
			cellView.underlineView.backgroundColor = .systemPurple
			cellView.balanceLabel.text = "Value"
		default:
			break
		}
	}
}
