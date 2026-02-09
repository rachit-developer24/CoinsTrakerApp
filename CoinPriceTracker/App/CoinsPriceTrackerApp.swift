//
//  CoinsPriceTrackerApp.swift
//  CoinsPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import SwiftUI

@main
struct CoinsPriceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            CoinsView(service:CoinsService())
        }
    }
}
