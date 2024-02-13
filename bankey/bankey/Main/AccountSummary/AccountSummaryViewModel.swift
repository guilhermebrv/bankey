//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewModel {
	var data: [AccountSummaryData] = []
	
	public var numberOfRowsInSection: Int {
		return data.count
	}
	
	public func fetchAccountData() {
		Task {
			do {
				self.data = try await AccountSummaryDataService().getAccountData()
				DispatchQueue.main.async {
					NotificationCenter.default.post(name: .dataFetched, object: nil)
				}
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
