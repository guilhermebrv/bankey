//
//  AccountSummaryHeaderViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 14/02/2024.
//

import UIKit

protocol AccountSummaryHeaderViewModelDelegate: AnyObject {
	func profileDataFetched()
}

class AccountSummaryHeaderViewModel {
	var data: AccountProfileData = AccountProfileData()
	var userId = "2"
	weak var delegate: AccountSummaryHeaderViewModelDelegate?
	var accountManager: AccountManager = AccountSummaryDataManager()
	
	public func fetchProfileData() {
		Task {
			do {
				self.data = try await accountManager.getProfileData(forUserId: userId)
				delegate?.profileDataFetched()
			} catch {
				print(error)
			}
		}
	}
}
