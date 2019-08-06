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

	// MARK: - WorkshopDetailInteractorInputProtocol
    func fetchCarWorkshopDetail(with id: String) {
        GoogleAPIManager.shared.getPlaceDetail(with: "ChIJ6SZoHaVVzpQRuE9OpSRuu-w") { [weak self] (result, error) in
            
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

    // MARK: - Private Methods

}
