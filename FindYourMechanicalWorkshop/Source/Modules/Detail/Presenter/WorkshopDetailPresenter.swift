//
//  WorkshopDetailPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopDetailPresenter: NSObject, WorkshopDetailPresenterInputProtocol, WorkshopDetailInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: WorkshopDetailPresenterOutputProtocol!
    var interactor: WorkshopDetailInteractorInputProtocol!
    var router: WorkshopDetailRouterProtocol!

    // MARK: - WorkshopDetailPresenterInputProtocol
    func viewDidLoad() {
        
    }

    // MARK: - WorkshopDetailPresenterInteractorOutputProtocol
    func handleSuccess(with result: Workshop) {
        
    }
    
    func handleFailure(with message: String) {
        
    }
    

	// MARK: - Private Methods

}
