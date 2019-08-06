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
    
	// MARK: - Viper Module Properties
    weak var output: WorkshopListInteractorOutputProtocol!

	// MARK: - WorkshopListInteractorInputProtocol
    func fetchCarWorkshopList(near location: Location) {
        GoogleAPIManager.shared.getPlacesNear(location: location, type: workshopType) { [weak self] (result, error) in
            
            if let aError = error {
                self?.output.handleFailure(with: aError.errorDescription ?? GoogleStatusResult.unknownError.errorDescription)
            } else {
                guard let workshops = result else {
                    self?.output.handleFailure(with: GoogleStatusResult.unknownError.errorDescription)
                    return
                }
                
                if workshops.isEmpty {
                    self?.output.handleFailure(with: GoogleStatusResult.zeroResults.errorDescription)
                } else {
                    self?.output.handleSuccess(with: workshops)
                }
            }
        }
    }

    // MARK: - Private Methods

}
