//
//  GoogleHTTPService.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 31/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Keys
import Moya

/// Configuration to access Google API
fileprivate struct GoogleAPIConfig {
    fileprivate static let keys = FindYourMechanicalWorkshopKeys()
    static let apiKey = keys.googleApiKey
}

// FIXME: Add documentation for this enum!
enum GoogleAPI: TargetType {
    
    // MARK: - Google API Cases
    
    case findPlacesNear(location: Location, type: String?)
    case findDetail(id: String)
    
    // MARK: - Moya Target Type Properties
    
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/")!
    }
    
    var path: String {
        switch self {
        case .findPlacesNear(_, _): return "nearbysearch/json"
        case .findDetail(_): return "details/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findPlacesNear(_, _): return .get
        case .findDetail(_): return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        let authParams: [String : Any] = ["key": GoogleAPIConfig.apiKey]
        
        switch self {
        case .findPlacesNear(let location, let type):
            var params: [String : Any] = [
                "location":"\(location.latitude),\(location.longitude)",
                "rankby": "distance"
            ]
            params.merge(authParams){(current, _) in current}
            if let aType = type {
                params.merge(["type": aType]){(current, _) in current}
                return params
            }
            return params
        case .findDetail(let id):
            var params: [String : Any] = [
                "placeid":"\(id)"
            ]
            params.merge(authParams){(current, _) in current}
            return params
        }
    }
    
    var task: Task {
        switch self {
        case .findPlacesNear(_, _):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .findDetail(_):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
