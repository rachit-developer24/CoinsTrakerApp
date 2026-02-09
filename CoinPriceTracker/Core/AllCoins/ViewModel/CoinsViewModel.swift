//
//  CoinsViewModel.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import Foundation
import Combine
@MainActor
class CoinsViewModel:ObservableObject{

    @Published var coins: [Coin] = []
    @Published var error: CoinsApiError?
    @Published var contentLoadingState: ContentLoadingState = .loading
    let service:CoinsServiceProtocol
    init(service:CoinsServiceProtocol){
        self.service = service
    }
   
    func fetchCoins()async{
        do{
            self.coins = try await service.fetchCoins()
            print("\(coins.count)")
            self.contentLoadingState = coins.isEmpty ? .empty : .complete
        }catch let  error as CoinsApiError{
            print("Debug:error is found \(error.customDescription)")
            self.error = error
            self.contentLoadingState = .error
        }catch{
            print("Debug:error is found \(error)")
            self.error = .unknownError(error: error)
            self.contentLoadingState = .error
        }
    }
}
