//
//  WorkshopListInteractor.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopListInteractor: NSObject, WorkshopListInteractorInputProtocol {
    
    // MARK: - Properties
    private var workshops: [Workshop] = []
    private let workshopType = "car_repair"
    
    private let client: GoogleAPIManager
    
    init(client: GoogleAPIManager) {
        self.client = client
    }
    
	// MARK: - Viper Module Properties
    weak var output: WorkshopListInteractorOutputProtocol!

	// MARK: - WorkshopListInteractorInputProtocol
    func fetchCarWorkshopList(near location: Location) {
        client.getPlacesNear(location: location, type: workshopType) { [weak self] (result, error) in
            
            if let aError = error {
                switch aError {
                case .requestMapping(let message):
                    self?.output.handleFailure(with: message)
                default:
                    self?.output.handleFailure(with: aError.errorDescription ?? GoogleStatusResult.unknownError.errorDescription)
                }
            } else {
                guard let workshops = result else {
                    self?.output.handleFailure(with: GoogleStatusResult.unknownError.errorDescription)
                    return
                }
                self?.output.handleSuccess(with: workshops)
            }
        }
    }
    
    func getPhotoURL(with reference: String, maxWidth: Int) -> String {
        return client.getPhotoURL(with: reference, maxWidth: maxWidth)
    }
}
