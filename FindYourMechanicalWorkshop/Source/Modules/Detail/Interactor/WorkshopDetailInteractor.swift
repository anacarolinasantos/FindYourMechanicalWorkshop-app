//
//  WorkshopDetailInteractor.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopDetailInteractor: NSObject, WorkshopDetailInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: WorkshopDetailInteractorOutputProtocol!

	// MARK: - WorkshopDetailInteractorInputProtocol
    func fetchCarWorkshopDetail(with id: String) {
        GoogleAPIManager.shared.getPlaceDetail(with: "ChIJ6SZoHaVVzpQRuE9OpSRuu-w") { [unowned self] (result, error) in
            
            if error != nil {
                self.output.handleFailure(with: "deu erro!")
            } else {
                guard let workshop = result else {
                    self.output.handleFailure(with: "outro erro!")
                    return
                }
                self.output.handleSuccess(with: workshop)
            }
        }
    }

    // MARK: - Private Methods

}
