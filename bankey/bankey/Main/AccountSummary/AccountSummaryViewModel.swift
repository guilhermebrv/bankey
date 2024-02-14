//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewModel {
	var userId = "2"
	var data: [AccountSummaryData] = []
	
	
	public var numberOfRowsInSection: Int {
		return data.count
	}
	
	public func fetchAccountData() {
		Task {
			do {
				self.data = try await AccountSummaryDataService().getAccountData(forUserId: userId)
			} catch {
				print(error)
			}
		}
	}
	
	public func loadCurrentTableViewCell(indexPath: IndexPath) -> AccountSummaryData {
		return data[indexPath.row]
	}
	
	public var heightForRowAt: CGFloat {
		return 90
	}
	
}
