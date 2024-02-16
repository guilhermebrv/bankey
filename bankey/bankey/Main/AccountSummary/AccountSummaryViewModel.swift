//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

protocol AccountSummaryViewModelDelegate: AnyObject {
	func accountDataFetched()
	func errorOccurred(error: Error)
}

class AccountSummaryViewModel {
	var data: [AccountSummaryData] = []
	weak var delegate: AccountSummaryViewModelDelegate?
	
	public var numberOfRowsInSection: Int {
		return data.count
	}
	
	public func fetchAccountData(_ userId: String) {
		Task {
			do {
				self.data = try await AccountSummaryDataService().getAccountData(forUserId: userId)
				delegate?.accountDataFetched()
			} catch {
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
