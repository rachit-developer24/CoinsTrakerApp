//
//  CoinsView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import SwiftUI

struct CoinsView: View {

    @StateObject var coinsViewModel: CoinsViewModel
    let service: CoinsServiceProtocol
    @State var SearchText: String = ""

   
    @State private var isRequestingNextPage = false

    init(service: CoinsServiceProtocol) {
        self.service = service
        _coinsViewModel = StateObject(
            wrappedValue: CoinsViewModel(service: service)
        )
    }

    var body: some View {
        NavigationStack {
            VStack {

                switch coinsViewModel.contentLoadingState {

                // ✅ EMPTY
                case .empty:
                    Text("coins is empty")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .frame(width: 360, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()

                // ✅ ERROR
                case .error:
                    if let error = coinsViewModel.error {
                        Text(error.customDescription)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .frame(width: 360, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                    }

                // ✅ LOADING
                case .loading:
                    ProgressView()

                // ✅ COMPLETE
                case .complete:
                    ZStack {

                        List(SearchedCoins) { coins in
                            NavigationLink(value: coins) {
                                CoinsSubView(coins: coins)
                            }
                            .onAppear {

                                // ✅ prevent pagination spam
                                guard !coinsViewModel.isRateLimited else { return }
                                guard !isRequestingNextPage else { return }

                                if coins.id == coinsViewModel.coins.last?.id {
                                    isRequestingNextPage = true

                                    Task {
                                        await coinsViewModel.fetchCoins()
                                        isRequestingNextPage = false
                                    }
                                }
                            }
                        }

                        // ✅ rate limit overlay (clean UX)
                        if coinsViewModel.isRateLimited {
                            ProgressView("Retrying too many api requests...")
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .searchable(text: $SearchText, prompt: "Search Coins...")
            .navigationTitle("Coins")
            .navigationDestination(for: Coin.self) { coins in
                CoinDetailView(coin: coins, service: service)
            }
            
        }

        .task(id: coinsViewModel.coins.isEmpty) {
            if coinsViewModel.coins.isEmpty {
                await coinsViewModel.fetchCoins()
            }
        }
    }
}
extension CoinsView {
    var SearchedCoins: [Coin] {
        return coinsViewModel.searchCoins(with:SearchText )
    }
}

#Preview {
    CoinsView(service: CoinsService())
}
