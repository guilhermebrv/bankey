//
//  AccountSummaryViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewController: UIViewController {
	
	private var accountSummaryView: AccountSummaryView?
	private var viewModel: AccountSummaryViewModel = AccountSummaryViewModel()
	
	override func loadView() {
		accountSummaryView = AccountSummaryView()
		view = accountSummaryView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		setupHeaderTableView()
    }
}

extension AccountSummaryViewController {
	private func signProtocols() {
		accountSummaryView?.tableView.delegate = self
		accountSummaryView?.tableView.dataSource = self
	}
	private func setupHeaderTableView() {
		let header = AccountSummaryHeaderView(frame: .zero)
		
		var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = UIScreen.main.bounds.width
		header.frame.size = size
		
		accountSummaryView?.tableView.tableHeaderView = header
	}
}

extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.identifier, for: indexPath) as? AccountSummaryTableViewCell
		cell?.setupCell(with: viewModel.loadCurrentTableViewCell(indexPath: indexPath))
		return cell ?? UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//
	}
}
