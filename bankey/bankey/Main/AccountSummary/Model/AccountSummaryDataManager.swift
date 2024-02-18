//
//  AccountSummaryDataManager.swift
//  bankey
//
//  Created by Guilherme Viana on 13/02/2024.
//

import UIKit

protocol AccountManager: AnyObject {
	func getAccountData(forUserId userId: String) async throws -> [AccountSummaryData]
	func getProfileData(forUserId userId: String) async throws -> AccountProfileData
}

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case invalidData
}

class AccountSummaryDataManager: AccountManager {
	public func getAccountData(forUserId userId: String) async throws -> [AccountSummaryData] {
		let endpoint = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts"
		
		guard let url = URL(string: endpoint) else {
			throw NetworkError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
				
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let result = try decoder.decode([AccountSummaryData].self, from: data)
			return result
		} catch {
			throw NetworkError.invalidData
		}
	}
	
	public func getProfileData(forUserId userId: String) async throws -> AccountProfileData {
		let endpoint = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)"
		
		guard let url = URL(string: endpoint) else {
			throw NetworkError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
				
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let result = try decoder.decode(AccountProfileData.self, from: data)
			return result
		} catch {
			throw NetworkError.invalidData
		}
	}
}
