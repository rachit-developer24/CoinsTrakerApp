//
//  MockCoins_InvalidJSON.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 10/02/2026.
//

import Foundation
//invalid name key in bitcoin
let mockCoins_invalidJSON:Data =
  """
 [
  {
    "id": "bitcoin",
    "symbol": "btc",
    "kjsahdfjkja": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
    "current_price": 43125.42,
    "market_cap": 845123456789,
    "market_cap_rank": 1,
    "total_volume": 23456789012,
    "high_24h": 43890.12,
    "low_24h": 42110.33,
    "price_change_24h": 510.67,
    "price_change_percentage_24h_in_currency": 1.198,
    "market_cap_change_24h": 9567890123,
    "market_cap_change_percentage_24h": 1.145,
    "circulating_supply": 19567843.0,
    "total_supply": 21000000.0,
    "max_supply": 21000000.0,
    "ath": 69000.0,
    "ath_change_percentage": -37.5,
    "ath_date": "2021-11-10T14:24:11.000Z",
    "atl": 67.81,
    "atl_change_percentage": 63521.3,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2023-08-31T17:30:00.559Z"
  },
  {
    "id": "ethereum",
    "symbol": "eth",
    "name": "Ethereum",
    "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
    "current_price": 3120.55,
    "market_cap": 375234567890,
    "market_cap_rank": 2,
    "total_volume": 14567890123,
    "high_24h": 3190.44,
    "low_24h": 3055.21,
    "price_change_24h": -25.87,
    "price_change_percentage_24h_in_currency": -0.823,
    "market_cap_change_24h": -2789012345,
    "market_cap_change_percentage_24h": -0.738,
    "circulating_supply": 120456789.0,
    "total_supply": 120456789.0,
    "max_supply": null,
    "ath": 4878.26,
    "ath_change_percentage": -36.0,
    "ath_date": "2021-11-10T14:24:19.000Z",
    "atl": 0.43,
    "atl_change_percentage": 725123.4,
    "atl_date": "2015-10-21T00:00:00.000Z",
    "roi": null,
    "last_updated": "2023-08-31T17:31:02.123Z"
  }]
 """.data(using: .utf8)!
