//
//  GoogleAPIManager.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 31/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Moya
import GooglePlaces

class GoogleAPIManager {
    
    // MARK: - Static Reference
    static let shared = GoogleAPIManager()
    
    // MARK: - Private Properties
    var provider: MoyaProvider<GoogleAPI>
    
    // MARK: - Private Initializer
    private init() {
        provider = MoyaProvider<GoogleAPI>()
    }
    
    // MARK: - Private Methods
    private func requestObject<T: Decodable>(_ token: GoogleAPI, completion: @escaping (T?, MoyaError?) -> Void) {
        provider.request(token) { [weak self] result in
            switch result {
            case .success(let response):
                do{
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let object = try filterResponse.map(GooglePlaceResult<T>.self)
                    
                    if let googleError = self?.filterGoogleSuccessfulStatus(with: object.status) {
                        completion(nil, googleError)
                    } else {
                        completion(object.result, nil)
                    }
                } catch let error {
                    completion(nil, error as? MoyaError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private func requestArray<T: Decodable>(_ token: GoogleAPI, completion: @escaping ([T]?, MoyaError?) -> Void) {
        provider.request(token) { [weak self] result in
            switch result {
            case .success(let response):
                do{
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let object = try filterResponse.map(GooglePlaceResults<T>.self)
                    
                    if let googleError = self?.filterGoogleSuccessfulStatus(with: object.status) {
                        completion(nil, googleError)
                    } else {
                        completion(object.results, nil)
                    }
                } catch let error {
                    completion(nil, error as? MoyaError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private func requestImage(_ token: GoogleAPI, completion: @escaping (Data?, MoyaError?) -> Void) {
        provider.request(token) { result in
            switch result {
            case .success(let response):
                do{
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    completion(filterResponse.data, nil)
                } catch let error {
                    completion(nil, error as? MoyaError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private func filterGoogleSuccessfulStatus(with status: String) -> MoyaError? {
        var error: GoogleStatusResult
        switch status {
        case GoogleStatusResult.zeroResults.rawValue:
            error = GoogleStatusResult.zeroResults
        case GoogleStatusResult.overQueryLimit.rawValue:
            error = GoogleStatusResult.overQueryLimit
        case GoogleStatusResult.requestDenied.rawValue:
            error = GoogleStatusResult.requestDenied
        case GoogleStatusResult.invalidRequest.rawValue:
            error = GoogleStatusResult.invalidRequest
        case GoogleStatusResult.unknownError.rawValue:
            error = GoogleStatusResult.unknownError
        default: return nil
        }
        return MoyaError.requestMapping(error.errorDescription)
    }
    
    // MARK: - Public Methods
    func getPlacesNear(location: Location, type: String?, completion: @escaping ([Workshop]?, MoyaError?) -> Void) {
        requestArray(.findPlacesNear(location: location, type: type),
                     completion: completion)
    }
    
    func getPlaceDetail(with id: String, completion: @escaping (Workshop?, MoyaError?) -> Void) {
        requestObject(.findDetail(id: id), completion: completion)
    }
    
    func getPhotoURL(with reference: String, maxWidth: Int) -> String {
        if let request = try? MoyaProvider.defaultEndpointMapping(for: GoogleAPI.getPhoto(reference: reference, maxWidth: maxWidth)).urlRequest(),
            let url = request.url {
            let key = url.absoluteString
            return key
        }
        return ""
    }
}
