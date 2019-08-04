//
//  WorkshopDetailPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopDetailPresenter: NSObject, WorkshopDetailPresenterInputProtocol, WorkshopDetailInteractorOutputProtocol {

    // MARK: - Properties
    private var workshop: Workshop
    
	// MARK: - Viper Module Properties
    weak var view: WorkshopDetailPresenterOutputProtocol!
    var interactor: WorkshopDetailInteractorInputProtocol!
    var router: WorkshopDetailRouterProtocol!

    // MARK: - Initializer
    init(workshop: Workshop) {
        self.workshop = workshop
    }
    
    // MARK: - WorkshopDetailPresenterInputProtocol
    func viewDidLoad() {
        view.showLoading(true)
        interactor.fetchCarWorkshopDetail(with: workshop.id)
    }
    
    func showMapsLaunchOption() {
        view.presentMapsOption()
    }

    // MARK: - WorkshopDetailPresenterInteractorOutputProtocol
    func handleSuccess(with result: Workshop) {
        view.showLoading(false)
        workshop = result
        view.loadData(title: workshop.name)
    }
    
    func handleFailure(with message: String) {
        view.showLoading(false)
        view.showError(message: message)
    }
    

	// MARK: - Private Methods
}
