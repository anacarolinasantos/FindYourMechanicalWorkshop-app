//
//  WorkshopListPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopListPresenter: NSObject, WorkshopListPresenterInputProtocol, WorkshopListInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: WorkshopListPresenterOutputProtocol!
    var interactor: WorkshopListInteractorInputProtocol!
    var router: WorkshopListRouterProtocol!

    // MARK: - WorkshopListPresenterInputProtocol

    // MARK: - WorkshopListPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
