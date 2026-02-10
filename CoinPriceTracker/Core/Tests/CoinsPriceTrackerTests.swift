//
//  CoinsPriceTrackerTests.swift
//  CoinPriceTrackerTests
//
//  Created by Rachit Sharma on 09/02/2026.
//

import XCTest
@testable import CoinPriceTracker
final class CoinsPriceTrackerTests: XCTestCase {

    
    func testDecodeCoinsIntoArray_MarketCapDesc() throws {
        do{
            let coins = try  JSONDecoder().decode([Coin].self, from:mockCoin_marketCapDesc)
            XCTAssertTrue(coins.count > 0) //ensures that coins array has coins
            XCTAssertEqual(coins.count, 20) //ensures that all coins were decoded
            XCTAssertEqual(coins, coins.sorted(by: {$0.marketCapRank < $1.marketCapRank})) //ensures sorting order
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
}
