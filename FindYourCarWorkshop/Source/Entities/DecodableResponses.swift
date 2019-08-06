//
//  DecodableResponses.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 03/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

enum GoogleStatusResult: String, Decodable {
    case zeroResults = "ZERO_RESULTS"
    case overQueryLimit = "OVER_QUERY_LIMIT"
    case requestDenied = "REQUEST_DENIED"
    case invalidRequest = "INVALID_REQUEST"
    case unknownError = "UNKNOWN_ERROR"
    
    public var errorDescription: String {
        switch self {
        case .zeroResults:
            return "Request returned zero results."
        case .overQueryLimit:
            return "Request over Google Places API quota."
        case .requestDenied:
            return "Request denied, generally because of invalid key parameter."
        case .invalidRequest:
            return "Invalid request, generally a required query parameter is missing."
        case .unknownError:
            return "Server-side error. Try again later."
        }
    }
}

struct GooglePlaceResults<T: Decodable>: Decodable {
    let results: [T]
    let status: String
}

struct GooglePlaceResult<T: Decodable>: Decodable {
    let result: T
    let status: String
}
