//
//  AccountSummaryViewModel.swift
//  bankey
//
//  Created by Guilherme Viana on 09/02/2024.
//

import UIKit

class AccountSummaryViewModel {
	
	let games = [ "Pacman", "Space Invaders", "Space Patrol"]
	
	public var numberOfRowsInSection: Int {
		return games.count
	}
	
	public var heightForRowAt: CGFloat {
		return 85
	}
	
}
