//
//  CoinsService.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import Foundation
protocol CoinsServiceProtocol{
    func fetchCoins()async throws -> [Coin]
    func fetchCoinsDetails(with id : String)async throws -> CoinDetails
}

class CoinsService:HttpDataDownloader,CoinsServiceProtocol{
    func fetchCoins()async throws -> [Coin]{
        guard let endpoint = allCoinsUrlString else{
            throw CoinsApiError.invalidUrl
        }
        return try await fetchData(as: [Coin].self, with: endpoint)
      
    }
    
    func fetchCoinsDetails(with id : String)async throws -> CoinDetails{
        if let cached = CoinsDetailsCache.shared.get(forkey: id){
            print("get coins from cache")
            return cached
        }
        print("get coins from api")
        guard let endpoint = coinDetailsUrl(id: id)else{
            throw CoinsApiError.invalidUrl
        }
        let details =  try await fetchData(as: CoinDetails.self, with: endpoint)
        CoinsDetailsCache.shared.set(details, forkey: id)
        return details
    }
    
    var baseUrlComponents:URLComponents{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        
        return components
    }
    
    var allCoinsUrlString:String?{
      var components = baseUrlComponents
        components.path += "markets"
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "100"),
            .init(name: "page", value: "1"),
            .init(name: "price_change_percentage", value: "24h"),
        ]
        return components.url?.absoluteString
    }
    
    func coinDetailsUrl(id:String)->String?{
        var components = baseUrlComponents
        components.path += "\(id)"
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return components.url?.absoluteString
    }
}
