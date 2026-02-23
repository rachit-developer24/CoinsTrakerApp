//
//  CoinsViewModel.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//
import Foundation
import Combine

@MainActor
class CoinsViewModel: ObservableObject {

    @Published var coins: [Coin] = []
    @Published var error: CoinsApiError?
    @Published var contentLoadingState: ContentLoadingState = .loading
    @Published var isRateLimited: Bool = false

    private var isPaginating: Bool = false
    private var nextAllowedFetch = Date.distantPast
    private var retryTask: Task<Void, Never>?

    let service: CoinsServiceProtocol

    init(service: CoinsServiceProtocol) {
        self.service = service
    }

    
    func searchCoins(with text: String)-> [Coin]{
        guard !text.isEmpty else {
            return coins
        }
        return coins.filter(
            {
                $0.name.localizedCaseInsensitiveContains(text) ||
                $0.symbol.localizedCaseInsensitiveContains(text)
        })
    }
    
    
    
    func fetchCoins() async {

        let now = Date()

       
        guard now >= nextAllowedFetch else {
            return
        }

       
        guard !isPaginating else { return }
        isPaginating = true
        defer { isPaginating = false }

        do {
            let newCoins = try await service.fetchCoins()

            
            nextAllowedFetch = Date().addingTimeInterval(1)

            coins.append(contentsOf: newCoins)

            contentLoadingState =
                (coins.isEmpty && newCoins.isEmpty) ? .empty : .complete

            error = nil
            isRateLimited = false

        } catch let err as CoinsApiError {

           
            if case .invalidStatusCode(let code) = err, code == 429 {

                isRateLimited = true

                
                nextAllowedFetch = Date().addingTimeInterval(20)

                retryTask?.cancel()

                retryTask = Task { [weak self] in
                    try? await Task.sleep(nanoseconds: 20_000_000_000)

                    guard let self else { return }

                    self.isRateLimited = false
                    await self.fetchCoins()
                }

                return
            }

           
            self.error = err
            self.contentLoadingState = .error

        } catch {
            self.error = .unknownError(error: error)
            self.contentLoadingState = .error
        }
    }
}
