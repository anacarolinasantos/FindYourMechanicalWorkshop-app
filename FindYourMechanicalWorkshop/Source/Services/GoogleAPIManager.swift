//
//  GoogleAPIManager.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 31/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Moya

final class GoogleAPIManager {
    
    // MARK: - Static Reference
    
    static let shared = GoogleAPIManager()
    
    // MARK: - Private Properties
    
//    private let persistencyManager = PersistencyManager()
    private let isOnMoyaProviderline = false
    private let provider: MoyaProvider<GoogleAPI>
    
    // MARK: - Private Initializer
    
    private init() {
        provider = MoyaProvider<GoogleAPI>()
    }
    
    // MARK: - Private Methods
    private func requestObject<T: Decodable>(_ token: GoogleAPI,
                                            completion: @escaping (T?, MoyaError?) -> Void) {
        
        provider.request(token) { result in
            switch result {
            case .success(let response):
                do{
                    // FIXME: Check status code to handle error
                    let t = try response.map(GooglePlaceResult<T>.self).result
                    completion(t, nil)
                } catch let error {
                    // FIXME: handle error
                    completion(nil, error as? MoyaError)
                }
            case .failure(let error):
                // FIXME: handle error
                completion(nil, error)
            }
        }
    }
    
    private func requestArray<T: Decodable>(_ token: GoogleAPI,
                      completion: @escaping ([T]?, MoyaError?) -> Void) {
        
        provider.request(token) { result in
            switch result {
            case .success(let response):
                do{
                    // FIXME: Check status code to handle error
                    let t = try response.map(GooglePlaceResults<T>.self).results
                    completion(t, nil)
                } catch let error {
                    // FIXME: handle error
                    completion(nil, error as? MoyaError)
                }
            case .failure(let error):
                // FIXME: handle error
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Public Methods
    func getPlacesNear(location: Location, type: String?, completion: @escaping ([Workshop]?, MoyaError?) -> Void) {
        requestArray(.findPlacesNear(location: location, type: type),
                     completion: completion)
    }
    
    func getPlaceDetail(with id: String, completion: @escaping (Workshop?, MoyaError?) -> Void) {
        requestObject(.findDetail(id: id), completion: completion)
    }
}
