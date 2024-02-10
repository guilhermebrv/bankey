//
//  Decimal.swift
//  bankey
//
//  Created by Guilherme Viana on 10/02/2024.
//

import UIKit

extension Decimal {
	var doubleValue: Double {
		return NSDecimalNumber(decimal:self).doubleValue
	}
}
