//
//  GoogleHTTPService.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 31/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Keys
import Moya

fileprivate struct GoogleAPIConfig {
    fileprivate static let keys = FindYourCarWorkshopKeys()
    static let apiKey = keys.googleApiKey
}

enum GoogleAPI: TargetType {
    
    // MARK: - Google API Cases
    case findPlacesNear(location: Location, type: String?)
    case findDetail(id: String)
    case getPhoto(reference: String, maxWidth: Int)
    
    // MARK: - Moya Target Type Properties
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/")!
    }
    
    var path: String {
        switch self {
        case .findPlacesNear(_, _): return "nearbysearch/json"
        case .findDetail(_): return "details/json"
        case .getPhoto(_, _): return "photo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findPlacesNear(_, _): return .get
        case .findDetail(_): return .get
        case .getPhoto(_, _): return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        let authParams: [String : Any] = ["key": GoogleAPIConfig.apiKey]
        var params: [String : Any]
        switch self {
        case .findPlacesNear(let location, let type):
            params = [
                "location":"\(location.latitude),\(location.longitude)",
                "rankby": "distance"
            ]
            if let aType = type {
                params.merge(["type": aType]){(current, _) in current}
                break
            }
        case .findDetail(let id):
            params = [
                "placeid":"\(id)"
            ]
        case .getPhoto(let reference, let maxWidth):
            params = [
                "photoreference": reference,
                "maxwidth": maxWidth
            ]
        }
        params.merge(authParams){(current, _) in current}
        return params
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
