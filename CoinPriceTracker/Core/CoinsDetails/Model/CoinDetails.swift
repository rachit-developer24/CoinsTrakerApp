//
//  CoinDetails.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 05/02/2026.
//

import Foundation
struct CoinDetails:Codable,Hashable{
    let id:String
    let name:String
    let symbol:String
    let description:Description
}
struct Description:Codable,Hashable{
    let text:String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
