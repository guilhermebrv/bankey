//
//  AccountSummaryData.swift
//  bankey
//
//  Created by Guilherme Viana on 10/02/2024.
//

import UIKit

let json = """
{
  "users": [
	{
	  "userId": "1",
	  "name": "John"
	},
	{
	  "userId": "2",
	  "name": "Jane"
	},
	{
	  "userId": "3",
	  "name": "Bob"
	}
  ]
}
"""

struct AccountSummaryData: Codable {
	var id, name: String?
	var type: AccountType?
	var amount: Decimal?
	var createdDateTime: Date?
	
	static func makeSkeleton() -> AccountSummaryData {
		return AccountSummaryData(id: "1", name: "Account name", type: .Banking, amount: 0.0, createdDateTime: Date())
	}
	
	var balanceAsAttributtedString: NSAttributedString {
		return CurrencyFormatter().makeAttributedCurrency(amount ?? 0)
	}
	
	var dateFormatted: String {
		return createdDateTime?.monthDayYearString ?? ""
	}
	
	enum AccountType: String, Codable {
		case Banking
		case CreditCard
		case Investment
	}
}

struct AccountProfileData: Codable {
	var id: String?
	var firstName: String?
	var lastName: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case firstName = "first_name"
		case lastName = "last_name"
	}
}
