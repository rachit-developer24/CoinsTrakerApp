//
//  CoinDetailView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 07/02/2026.
//

import SwiftUI
import Kingfisher

struct CoinDetailView: View {
    let coin: Coin
    @ObservedObject var viewModel: CoinsDetailViewModel

    init(coin: Coin, service: CoinsServiceProtocol) {
        self.coin = coin
        _viewModel = ObservedObject(
            wrappedValue: CoinsDetailViewModel(
                coinId: coin.id,
                service: service
            )
        )
    }

    var body: some View {
        VStack {

           
            if viewModel.isRateLimited {

                ProgressView("Too many requests. Retrying…")

            }
           
            else if viewModel.isloding {

                ProgressView()

            }
            
            else if let coindetails = viewModel.CoinsDetails {

                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        HStack{
                            Text(coindetails.name)
                                .fontWeight(.bold)
                            Spacer()
                            KFImage(URL(string: coin.image))
                                .resizable()
                                .frame(width: 65, height: 65)
                        }

                        Text(coindetails.symbol)
                            .foregroundStyle(.gray)

                        Text(coindetails.description.text)
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 360, alignment: .leading)
                    .padding(20)
                }

            }
           
            else {
                Text("No data available")
                    .foregroundStyle(.gray)
            }
        }
        .task {
            await viewModel.fetchCoinsDetail()
        }
        .overlay {
            
            if !viewModel.isRateLimited,
               let error = viewModel.error {

                Text(error.customDescription)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .frame(width: 360, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            }
        }
    }
}

