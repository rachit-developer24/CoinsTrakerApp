//
//  CoinDetailView.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 07/02/2026.
//

import SwiftUI
struct CoinDetailView: View {
    let coin:Coin
    @ObservedObject var viewModel:CoinsDetailViewModel
    init(coin: Coin, service: CoinsServiceProtocol) {
        self.coin = coin
        _viewModel = ObservedObject(wrappedValue: CoinsDetailViewModel(coinId: coin.id, service: service))
    }
    var body: some View {
        VStack{
            if viewModel.isloding{
                ProgressView()
            }else{
                VStack(spacing:25){
                    if let coindetails = viewModel.CoinsDetails{
                        ScrollView{
                            VStack(alignment:.leading){
                                Text(coindetails.name)
                                    .fontWeight(.bold)
                                Text(coindetails.symbol)
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: 360,alignment: .leading)
                            
                            Text(coindetails.description.text)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(20)
            }
        }
        .task {
            await viewModel.fetchCoinsDetail()
        }
        .overlay{
            if let error = viewModel.error{
                Text(error.customDescription)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .frame(width:360,height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
            }
        }
        
      
    }
}


