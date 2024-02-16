//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

protocol AccountSummaryViewModelDelegate: AnyObject {
	func accountDataFetched()
	func errorOccurred(error: NetworkError)
}

class AccountSummaryViewModel {
	var data: [AccountSummaryData] = []
	weak var delegate: AccountSummaryViewModelDelegate?
	var accountManager: AccountManager = AccountSummaryDataManager()
	
	public var numberOfRowsInSection: Int {
		return data.count
	}
	
	public func fetchAccountData(_ userId: String) {
		Task {
			do {
				self.data = try await accountManager.getAccountData(forUserId: userId)
				delegate?.accountDataFetched()
			} catch let error as NetworkError {
				delegate?.errorOccurred(error: error)
			}
		}
	}
	
	public func loadCurrentTableViewCell(indexPath: IndexPath) -> AccountSummaryData {
		return data[indexPath.row]
	}
	
	public var heightForRowAt: CGFloat {
		return 105
	}
	
}
