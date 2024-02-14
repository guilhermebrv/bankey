//
//  AccountSummaryHeaderViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 14/02/2024.
//

import UIKit

class AccountSummaryHeaderViewModel {
	var data: AccountProfileData = AccountProfileData()
	var userId = "2"
	
	public func fetchprofileData() {
		Task {
			do {
				self.data = try await AccountSummaryDataService().getProfileData(forUserId: userId)
			} catch {
				print(error)
			}
		}
	}
}
