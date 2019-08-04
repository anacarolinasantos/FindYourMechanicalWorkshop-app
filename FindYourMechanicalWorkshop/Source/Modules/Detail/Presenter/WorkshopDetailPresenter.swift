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

    // MARK: - WorkshopDetailPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
