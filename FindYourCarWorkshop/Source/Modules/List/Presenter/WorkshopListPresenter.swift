//
//  WorkshopListPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopListPresenter: NSObject, WorkshopListPresenterInputProtocol, WorkshopListInteractorOutputProtocol {

    // MARK: - Properties
    private var workshops: [Workshop] = []
    
	// MARK: - Viper Module Properties
    weak var view: WorkshopListPresenterOutputProtocol!
    var interactor: WorkshopListInteractorInputProtocol!
    var router: WorkshopListRouterProtocol!

    // MARK: - WorkshopListPresenterInputProtocol
    func viewDidLoad() {
        view.showLoading(true)
        
        let currentLocation = getCurrentLocation()
        
        interactor.fetchCarWorkshopList(near: currentLocation)
    }
    
    func searchWorkshops(near location: Location) {
        interactor.fetchCarWorkshopList(near: location)
    }
    
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return workshops.count
    }
    
    func item(at indexPath: Int) -> Workshop {
        return workshops[indexPath]
    }
    
    func didSelectItem(at indexPath: Int) {
        router.pushToCarWorkshopDetail(with: workshops[indexPath])
    }

    // MARK: - WorkshopListPresenterInteractorOutputProtocol
    func handleSuccess(with results: [Workshop]) {
        workshops = results
        view.showLoading(false)
        view.reloadData()
    }
    
    func handleFailure(with message: String) {
        view.showLoading(false)
        view.showError(message: message)
    }
    
    // MARK: - Private Methods
    func getCurrentLocation() -> Location {
        return Location(-23.586079, -46.7786114)
    }
}
