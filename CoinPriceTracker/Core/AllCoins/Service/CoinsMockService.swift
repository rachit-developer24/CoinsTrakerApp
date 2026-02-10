//
//  CoinsMockService.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 08/02/2026.
//

import Foundation
class CoinsMockService:CoinsServiceProtocol{
    
    var mockData:Data?
    var mockError:CoinsApiError?
    
    func fetchCoins() async throws -> [Coin] {
        if let error = mockError{
            throw error
        }
        do{
            return try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoin_marketCapDesc)
        }catch{
            throw error as? CoinsApiError ?? .unknownError(error: error)
        }
    }
    
    func fetchCoinsDetails(with id: String) async throws -> CoinDetails {
        return CoinDetails(id: "1", name: "bitcoin", symbol: "btc", description: Description.init(text: "bitcoin is a digital currency"))
    }
    
    
}
