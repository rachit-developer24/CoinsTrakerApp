//
//  CoinsService.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import Foundation

class CoinsService{
    func fetchCoins()async throws -> [Coin]{
          let urlString =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        
        guard let Url = URL(string: urlString)else{throw CoinsApiError.invalidUrl}
        let (data,response) = try await URLSession.shared.data(from: Url)
        guard let UrlResponse = response as? HTTPURLResponse else{throw CoinsApiError.requestFailed(description: "invalid Response")}
        guard UrlResponse.statusCode == 200 else{throw CoinsApiError.invalidStatusCode(statusCode: UrlResponse.statusCode)}
        do{
            return try JSONDecoder().decode([Coin].self, from: data)
        }catch{
            throw error as? CoinsApiError ?? .unknownError(error: error)
        }
    }
    
    func fetchCoinsDetails(with id : String)async throws -> CoinDetails{
        let urlString =  "https://api.coingecko.com/api/v3/coins/\(id)"
        guard let url = URL(string: urlString)else{throw CoinsApiError.invalidUrl}
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let Urlresponse = response as? HTTPURLResponse else{throw CoinsApiError.requestFailed(description: "invalid Response")}
        guard Urlresponse.statusCode == 200 else{
            throw CoinsApiError.invalidStatusCode(statusCode: Urlresponse.statusCode)
        }
        do{
            return try JSONDecoder().decode(CoinDetails.self, from: data)
        }catch{
            throw error as? CoinsApiError ?? .unknownError(error: error)
        }
    }
    
    
}
