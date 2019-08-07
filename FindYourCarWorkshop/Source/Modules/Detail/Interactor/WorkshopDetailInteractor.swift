//
//  WorkshopDetailInteractor.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import Moya

class WorkshopDetailInteractor: NSObject, WorkshopDetailInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: WorkshopDetailInteractorOutputProtocol!

    private let client: GoogleAPIManager
    
    init(client: GoogleAPIManager) {
        self.client = client
    }
    
	// MARK: - WorkshopDetailInteractorInputProtocol
    func fetchCarWorkshopDetail(with id: String) {
        client.getPlaceDetail(with: id) { [weak self] (result, error) in
            
            if let aError = error {
                switch aError {
                case .requestMapping(let message):
                    self?.output.handleFailure(with: message)
                default:
                    self?.output.handleFailure(with: aError.errorDescription ?? GoogleStatusResult.unknownError.errorDescription)
                }
            } else {
                guard let workshop = result else {
                    self?.output.handleFailure(with: GoogleStatusResult.unknownError.errorDescription)
                    return
                }
                self?.output.handleSuccess(with: workshop)
            }
        }
    }
    
    func getPhotoURL(with reference: String, maxWidth: Int) -> String {
        return client.getPhotoURL(with: reference, maxWidth: maxWidth)
    }
}
