//
//  Coins.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import Foundation

struct Coin:Codable,Identifiable,Hashable{
    
    var id:String
    let symbol:String
    let name:String
    let currentPrice:Double
    let marketCapRank:Int
    let image:String
    let priceChangePercentage24H: Double?

    enum CodingKeys: String, CodingKey {
        case id,name,symbol,image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}
