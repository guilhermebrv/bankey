//
//  AccountSummaryViewController.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewController: UIViewController {
	
	var userId = "2"
	var isDataLoaded = false
	private var accountSummaryView: AccountSummaryView?
	private var viewModel: AccountSummaryViewModel = AccountSummaryViewModel()
	private var headerViewModel: AccountSummaryHeaderViewModel = AccountSummaryHeaderViewModel()
	private var header = AccountSummaryHeaderView(frame: .zero)
	
	lazy var errorAlert: UIAlertController = {
		let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
			self.viewModel.fetchAccountData(self.userId)
		}))
		return alert
	}()
	
	override func loadView() {
		accountSummaryView = AccountSummaryView()
		view = accountSummaryView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		headerViewModel.fetchProfileData()
		viewModel.fetchAccountData(userId)
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
		viewModel.delegate = self
		headerViewModel.delegate = self
	}
	private func setupHeaderTableView() {
		var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = UIScreen.main.bounds.width
		header.frame.size = size
	
		accountSummaryView?.tableView.tableHeaderView = header
	}
	private func updateUI() {
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

extension AccountSummaryViewController: AccountSummaryViewControllerDelegate, AccountSummaryViewModelDelegate, AccountSummaryHeaderViewModelDelegate {
	func errorOccurred(error: NetworkError) {
		let titleAndMessage = titleAndMessage(for: error)
		DispatchQueue.main.async {
			self.errorAlert.title = titleAndMessage.0
			self.errorAlert.message = titleAndMessage.1
			self.present(self.errorAlert, animated: true)
		}
	}
	
	private func titleAndMessage(for error: NetworkError) -> (String, String) {
		let title: String = "Error"
		let message: String
		switch error {
		case .invalidURL:
			message = "The URL provided was invalid. Please try again later."
		case .invalidResponse:
			message = "We received an invalid response from the server. Please ensure you are connected to the internet."
		case .invalidData:
			message = "The data received from the server was invalid. Please try again later."
		}
		return (title, message)
	}
	
	func refreshData() {
		accountSummaryView?.tableView.refreshControl?.beginRefreshing()
		isDataLoaded = false
		accountSummaryView?.tableView.reloadData()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.viewModel.fetchAccountData(self.userId)
		}
	}
	
	func accountDataFetched() {
		DispatchQueue.main.async {
			self.accountSummaryView?.tableView.refreshControl?.endRefreshing()
			self.isDataLoaded = true
			self.accountSummaryView?.tableView.reloadData()
		}
	}
	
	func profileDataFetched() {
		DispatchQueue.main.async {
			self.updateUI()
		}
	}
	
	func didLogout() {
		NotificationCenter.default.post(name: .logout, object: nil)
	}
}

extension AccountSummaryViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isDataLoaded {
			return viewModel.numberOfRowsInSection
		}
		return 8
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if isDataLoaded {
			let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.identifier, for: indexPath) as? AccountSummaryTableViewCell
			cell?.setupCell(with: viewModel.loadCurrentTableViewCell(indexPath: indexPath))
			return cell ?? UITableViewCell()
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.identifier, for: indexPath) as? SkeletonCell
			return cell ?? UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//
	}
}

// unit testing
extension AccountSummaryViewController {
	func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
		return titleAndMessage(for: error)
	}
}
