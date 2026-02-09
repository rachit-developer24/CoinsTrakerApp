//
//  CoinsMockService.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 08/02/2026.
//

import Foundation
class CoinsMockService:CoinsServiceProtocol{
    func fetchCoins() async throws -> [Coin] {
        return [Coin(id: "1", symbol: "btc", name: "bitcoin", currentPrice: 2.00, marketCapRank: 1)]
    }
    
    func fetchCoinsDetails(with id: String) async throws -> CoinDetails {
        return CoinDetails(id: "1", name: "bitcoin", symbol: "btc", description: Description.init(text: "bitcoin is a digital currency"))
    }
    
    
}
