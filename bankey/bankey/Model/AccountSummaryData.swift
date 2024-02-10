//
//  AccountSummaryData.swift
//  bankey
//
//  Created by Guilherme Viana on 10/02/2024.
//

import UIKit

enum AccountType: String {
	case Banking
	case CreditCard
	case Investment
}

struct AccountSummaryData {
		var accountType: AccountType?
		var accountName: String?
		var balance: Decimal?
	
	var balanceAsAttributtedString: NSAttributedString {
		return CurrencyFormatter().makeAttributedCurrency(balance ?? 0)
	}
}
