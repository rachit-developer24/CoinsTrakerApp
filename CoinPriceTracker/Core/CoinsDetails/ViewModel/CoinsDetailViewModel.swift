//
//  CoinsDetailViewModel.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 07/02/2026.
//

import Foundation
import Combine
class CoinsDetailViewModel:ObservableObject{
    @Published var CoinsDetails:CoinDetails?
    @Published var error:CoinsApiError?
    @Published var isloding:Bool = false
    let coinId:String
    let service = CoinsService()
    init(coinId:String){
        self.coinId = coinId
    }
    func fetchCoinsDetail()async {
        isloding = true
        defer {
            isloding = false
        }
        do{
            self.CoinsDetails = try await service.fetchCoinsDetails(with: coinId)
        }catch let error as CoinsApiError{
            self.error = error
        }catch{
            self.error = .unknownError(error: error)
        }
    }
}
