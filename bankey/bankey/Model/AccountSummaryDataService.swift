//
//  AccountSummaryDataService.swift
//  bankey
//
//  Created by Guilherme Viana on 13/02/2024.
//

import UIKit

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case invalidData
}

class AccountSummaryDataService {
	public func getAccountData() async throws -> [AccountSummaryData] {
		let endpoint = "https://run.mocky.io/v3/776516fb-27ef-4262-b215-243e5a09c6f7"
		
		guard let url = URL(string: endpoint) else {
			throw NetworkError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
				
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		do {
			//let jsonData = data.data(using: .utf8)!
			let decoder = JSONDecoder()
			//decoder.dateDecodingStrategy = .iso8601
			let result = try decoder.decode([AccountSummaryData].self, from: data)
			return result
		} catch {
			throw NetworkError.invalidData
		}
	}

}
