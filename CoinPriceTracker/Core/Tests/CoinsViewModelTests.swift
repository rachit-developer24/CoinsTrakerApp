//
//  CoinsViewModelTests.swift
//  CoinPriceTrackerTests
//
//  Created by Rachit Sharma on 09/02/2026.
//

import XCTest
@testable import CoinPriceTracker

final class CoinsViewModelTests: XCTestCase {

    var viewModel: CoinsViewModel!

    @MainActor
    override func tearDown() {
        viewModel = nil          // ✅ dealloc happens on MainActor
        super.tearDown()
    }

    @MainActor
    func testInit() {
        let service = CoinsMockService()
        viewModel = CoinsViewModel(service: service)
        
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertEqual(viewModel.contentLoadingState, .loading)
    }
    
    @MainActor
    func testSuccessfulCoinsFetch() async{
        let service = CoinsMockService()
        viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins .count > 0)
        XCTAssertTrue(viewModel.coins.count > 0)
        XCTAssertEqual(viewModel.coins.count, 20)
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted(by: {$0.marketCapRank < $1.marketCapRank}))
    }
    
    @MainActor
    func testCoinFetchWithInvalidJeson() async{
        let service = CoinsMockService()
        service.mockData = mockCoins_invalidJSON
        viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins .isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    @MainActor
    func testThrowsInvalidDataError() async {
        let service = CoinsMockService()
        service.mockError = .invalidData
        viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.customDescription,CoinsApiError.invalidData.customDescription)
    }
    @MainActor
    func testThrowsInvalidStatusCodeError() async {
        let service = CoinsMockService()
        service.mockError = .invalidStatusCode(statusCode: 404)
        viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.customDescription,CoinsApiError.invalidStatusCode(statusCode: 404).customDescription)
    }
    
    
    
}


