//
//  AccountSummaryData.swift
//  bankey
//
//  Created by Guilherme Viana on 10/02/2024.
//

import UIKit

struct AccountSummaryData {
		var accountType: AccountType?
		var accountName: String?
		var balance: Decimal?
	
	var balanceAsAttributtedString: NSAttributedString {
		return CurrencyFormatter().makeAttributedCurrency(balance ?? 0)
	}
	
	enum AccountType: String {
		case Banking
		case CreditCard
		case Investment
	}
}
