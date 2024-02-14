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
	private var headerViewModel: AccountSummaryHeaderViewModel = AccountSummaryHeaderViewModel()
	private var header = AccountSummaryHeaderView(frame: .zero)
	
	override func loadView() {
		accountSummaryView = AccountSummaryView()
		view = accountSummaryView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		fetchDataAndLoadView()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.rightBarButtonItem = accountSummaryView?.logoutButton
		signProtocols()
		setupHeaderTableView()
    }
}

extension AccountSummaryViewController {
	private func signProtocols() {
		accountSummaryView?.tableView.delegate = self
		accountSummaryView?.tableView.dataSource = self
		accountSummaryView?.delegate = self
	}
	
	private func fetchDataAndLoadView() {
		let group = DispatchGroup()
		
		group.enter()
		headerViewModel.fetchprofileData()
		viewModel.fetchAccountData()
		group.leave()
		
		group.notify(queue: .main) {
			self.updateUI()
		}
	}
	private func setupHeaderTableView() {
		var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = UIScreen.main.bounds.width
		header.frame.size = size
	
		accountSummaryView?.tableView.tableHeaderView = header
	}
	
	@objc func updateUI() {
		let hour = Calendar.current.component(.hour, from: .now)
		var greeting = "Good morning"
		if hour >= 12 && hour < 19 {
			greeting = "Good afternoon"
		} else if hour >= 19 || hour < 06 {
			greeting = "Good evening"
		}
		header.welcomeLabel.text = greeting
		header.nameLabel.text = headerViewModel.data.firstName
		header.dateLabel.text = Date().monthDayYearString
		accountSummaryView?.tableView.reloadData()
	}
}

extension AccountSummaryViewController: AccountSummaryViewControllerDelegate {
	func didLogout() {
		NotificationCenter.default.post(name: .logout, object: nil)
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
