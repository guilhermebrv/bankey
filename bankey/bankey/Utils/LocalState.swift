//
//  LocalState.swift
//  bankey
//
//  Created by Guilherme Viana on 08/02/2024.
//

import Foundation

public class LocalState {
	public static let shared = LocalState()
		
	public static var hasOnboarded: Bool {
		get {
			return UserDefaults.standard.bool(forKey: "hasOnboarded")
		}
		set(newValue) {
			UserDefaults.standard.set(newValue, forKey: "hasOnboarded")
			UserDefaults.standard.synchronize()
		}
	}
}
