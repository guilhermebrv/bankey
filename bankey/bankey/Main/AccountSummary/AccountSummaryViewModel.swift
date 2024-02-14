//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

protocol AccountSummaryViewModelDelegate: AnyObject {
	func accountDataFetched()
}

class AccountSummaryViewModel {
	var data: [AccountSummaryData]?
	weak var delegate: AccountSummaryViewModelDelegate?
	
	public var numberOfRowsInSection: Int {
		return data?.count ?? 10
	}
	
	public func setupSkeletons() {
		let row = AccountSummaryData.makeSkeleton()
		data = Array(repeating: row, count: 10)
	}
	
	public func fetchAccountData(_ userId: String) {
		Task {
			do {
				self.data = try await AccountSummaryDataService().getAccountData(forUserId: userId)
				delegate?.accountDataFetched()
			} catch {
				print(error)
			}
		}
	}
	
	public func loadCurrentTableViewCell(indexPath: IndexPath) -> AccountSummaryData {
		return data?[indexPath.row] ?? AccountSummaryData()
	}
	
	public var heightForRowAt: CGFloat {
		return 90
	}
	
}
