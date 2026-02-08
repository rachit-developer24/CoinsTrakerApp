//
//  CoinsView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import SwiftUI

struct CoinsView: View {
    @StateObject var coinsViewModel = CoinsViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                switch coinsViewModel.contentLoadingState {
                case .empty:
                    Text("coins is empty")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .frame(width:360,height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                case .error:
                    if let error = coinsViewModel.error {
                        Text(error.customDescription)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .frame(width:360,height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                    }
                case .loading:
                    ProgressView()
                case .complete:
                    List(coinsViewModel.coins) { coins in
                        NavigationLink(value: coins) {
                            CoinsSubView(coins: coins)
                        }
                    }
                    
                }
            }
            
            .navigationDestination(for: Coin.self) { coins in
                CoinDetailView(coin: coins)
            }
        }
        .task{
            await coinsViewModel.fetchCoins()
        }
        }
        }



#Preview {
    CoinsView()
}
