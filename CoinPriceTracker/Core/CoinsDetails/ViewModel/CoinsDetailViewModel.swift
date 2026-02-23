//
//  CoinsDetailViewModel.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 07/02/2026.
//

import Foundation
import Combine

@MainActor
class CoinsDetailViewModel: ObservableObject {

    @Published var CoinsDetails: CoinDetails?
    @Published var error: CoinsApiError?
    @Published var isloding: Bool = false
    @Published var isRateLimited: Bool = false

    private var nextAllowedFetch = Date.distantPast
    private var retryTask: Task<Void, Never>?   

    let coinId: String
    let service: CoinsServiceProtocol

    init(coinId: String, service: CoinsServiceProtocol) {
        self.coinId = coinId
        self.service = service
    }

    func fetchCoinsDetail() async {

        let now = Date()
        guard now >= nextAllowedFetch else { return }

        isloding = true
        defer { isloding = false }

        do {
            self.CoinsDetails = try await service.fetchCoinsDetails(with: coinId)
            self.error = nil

        } catch let err as CoinsApiError {
            if case .invalidStatusCode(let code) = err, code == 429 {
                isRateLimited = true
                nextAllowedFetch = Date().addingTimeInterval(10)
                retryTask?.cancel()
                retryTask = Task { [weak self] in
                    try? await Task.sleep(nanoseconds: 10_000_000_000) // 10 sec
                    guard let self else { return }
                    self.isRateLimited = false
                    await self.fetchCoinsDetail()
                }

                return
            }

            self.error = err

        } catch {
            self.error = .unknownError(error: error)
        }
    }
}

