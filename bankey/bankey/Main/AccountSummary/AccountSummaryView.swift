//
//  AccountSummaryView.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

protocol AccountSummaryViewControllerDelegate: AnyObject {
	func didLogout()
	func refreshData()
}

class AccountSummaryView: UIView {
	weak var delegate: AccountSummaryViewControllerDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var logoutButton: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
		button.tintColor = .label
		return button
	}()

	lazy var tableView: UITableView = {
		let table = UITableView()
		let refresh = UIRefreshControl()
		table.translatesAutoresizingMaskIntoConstraints = false
		table.showsVerticalScrollIndicator = false
		table.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.identifier)
		table.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.identifier)
		table.tableFooterView = UIView()
		table.backgroundColor = .appColor
		refresh.tintColor = .appColor
		refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
		table.refreshControl = refresh
		return table
	}()
}

extension AccountSummaryView {
	@objc func logoutTapped() {
		delegate?.didLogout()
	}
	@objc func refreshData() {
		delegate?.refreshData()
	}
}

extension AccountSummaryView {
	private func addElements() {
		addSubview(tableView)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
}
