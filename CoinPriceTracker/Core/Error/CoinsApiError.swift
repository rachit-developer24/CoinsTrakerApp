//
//  CoinsApiError.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 03/02/2026.
//

import Foundation
enum CoinsApiError:Error{
    case invalidUrl
    case invalidData
    case jsonParsingFailure
    case requestFailed(description:String)
    case invalidStatusCode(statusCode:Int)
    case unknownError(error:Error)
    
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid Data"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case let .requestFailed(description):return "Request Failed: \(description)"
        case let .invalidStatusCode(statusCode):return "Invalid Status Code: \(statusCode)"
        case let .unknownError(error):return "Unknown Error: \(error.localizedDescription)"
        case .invalidUrl:
            return "invalid Url"
        }
    }
}
