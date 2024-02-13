//
//  AccountSummaryData.swift
//  bankey
//
//  Created by Guilherme Viana on 10/02/2024.
//

import UIKit

let json = """
[
	{
		"id": "1",
		"type": "Banking",
		"name": "Checking Account",
		"amount": 1000.00,
	},
	{
		"id": "2",
		"type": "CreditCard",
		"name": "Credit Card",
		"amount": -1000.00,
	},
	{
		"id": "3",
		"type": "Investment",
		"name": "Investment Account",
		"amount": 10000.00,
	},
]
"""

struct AccountSummaryData: Codable {
	var id, name: String?
	var type: AccountType?
	var amount: Decimal?
	//var createdDateTime: Date?
	
	var balanceAsAttributtedString: NSAttributedString {
		return CurrencyFormatter().makeAttributedCurrency(amount ?? 0)
	}
	
	enum AccountType: String, Codable {
		case Banking
		case CreditCard
		case Investment
	}
}
