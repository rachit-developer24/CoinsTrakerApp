//
//  CoinsSubView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import SwiftUI

struct CoinsSubView: View {
    let coins:Coin
    var body: some View {
       
        HStack{
                Text("\(coins.marketCapRank)")
                    .foregroundStyle(.gray)
                VStack(alignment:.leading){
                    Text(coins.name)
                        .fontWeight(.bold)
                    Text(coins.symbol)
                }
            }
        }
            
        
    
}
            
        


#Preview {
    CoinsSubView(coins: Coin(id: UUID().uuidString, symbol: "Btc", name: "BitCoin", currentPrice: 0.0, marketCapRank: 1))
}
