//
//  Double.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 15/02/2026.
//

import Foundation

extension Double {
    func formattedCurrency() -> String {
        // Use the current locale's currency, default to USD if unavailable
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"
        formatter.maximumFractionDigits = self >= 1 ? 2 : 6
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "$\(self)"
    }

    func formattedPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self / 100)) ?? "\(self)%"
    }
}
