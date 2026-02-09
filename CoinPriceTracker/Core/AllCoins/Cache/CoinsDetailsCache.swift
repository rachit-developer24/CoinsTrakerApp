//
//  CoinsDetailsCache.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 08/02/2026.
//

import Foundation
class CoinsDetailsCache{
    
    static let shared = CoinsDetailsCache()
    
    
    let cache = NSCache<NSString,NSData>()
    
    func set(_ coinDetails:CoinDetails,forkey key:String){
        guard let data = try? JSONEncoder().encode(coinDetails) else{return}
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(forkey key:String)->CoinDetails?{
        guard let data = cache.object(forKey: key as NSString) as Data? else {
            return nil
        }
        return try?  JSONDecoder().decode(CoinDetails.self, from: data)
    }
}
