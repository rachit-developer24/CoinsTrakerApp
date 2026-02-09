//
//  HttpDataDownloader.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 08/02/2026.
//

import Foundation
protocol HttpDataDownloader{
    func fetchData<T:Codable>(as type :T.Type,with endpoint:String)async throws -> T
}
extension HttpDataDownloader{
    func fetchData<T:Decodable>(as type :T.Type,with endpoint:String)async throws -> T{
        guard let Url = URL(string: endpoint)else{throw CoinsApiError.invalidUrl}
        let (data,response) = try await URLSession.shared.data(from: Url)
        guard let UrlResponse = response as? HTTPURLResponse else{throw CoinsApiError.requestFailed(description: "invalid Response")}
        guard UrlResponse.statusCode == 200 else{throw CoinsApiError.invalidStatusCode(statusCode: UrlResponse.statusCode)}
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw error as? CoinsApiError ?? .unknownError(error: error)
        }
    }
}
