//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewModel {
	
	var data: [AccountSummaryData]?
	
	public var numberOfRowsInSection: Int {
		return data?.count ?? 1
	}
	
	public func loadCurrentTableViewCell(indexPath: IndexPath) -> AccountSummaryData {
		var accountData = AccountSummaryData()
		accountData.accountName = "Guilherme Viana"
		accountData.accountType = .CreditCard
		accountData.balance = 10000.50
		return accountData//data?[indexPath.row] ?? AccountSummaryData()
	}
	
	public var heightForRowAt: CGFloat {
		return 90
	}
	
}
