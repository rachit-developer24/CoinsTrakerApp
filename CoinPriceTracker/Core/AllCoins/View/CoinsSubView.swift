//
//  CoinsSubView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import SwiftUI
import Kingfisher

struct CoinsSubView: View {
    let coins:Coin
    var body: some View {
       
        HStack {
            Text("\(coins.marketCapRank)").foregroundStyle(.gray)

            KFImage(URL(string: coins.image))
                .resizable()
                .frame(width: 32, height: 32)

            VStack(alignment: .leading) {
                Text(coins.name).fontWeight(.bold)
                Text(coins.symbol.uppercased()).foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text(coins.currentPrice, format: .currency(code: "USD"))
                    .font(.headline.monospacedDigit())

                ChangePill(percentage: coins.priceChangePercentage24H)
            }
        }

        }
    
}
            
        


#Preview {
    CoinsSubView(coins: Coin(id: UUID().uuidString, symbol: "Btc", name: "BitCoin", currentPrice: 0.0, marketCapRank: 1, image: "", priceChangePercentage24H: 1.0))
}
