//
//  WorkshopListProtocols.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

// MARK: - Router
protocol WorkshopListRouterProtocol: class {
    func present(with viewController: UIViewController)
    func presentAsRoot(window: UIWindow)
    func pushToCarWorkshopDetail(with workshop: Workshop)
}

// MARK: - Interactor
protocol WorkshopListInteractorInputProtocol {
    func fetchCarWorkshopList(near location: Location)
    func getPhotoURL(with reference: String, maxWidth: Int) -> String
}

// MARK: - Presenter
protocol WorkshopListPresenterInputProtocol: class {
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    
    func item(at indexPath: Int) -> Workshop
    func didSelectItem(at indexPath: Int)
    
    func searchWorkshops(near location: Location)
    
    func getPhotoURL(at indexPath: Int) -> String?
}

protocol WorkshopListInteractorOutputProtocol: class {
    func handleSuccess(with results: [Workshop])
    func handleFailure(with message: String)
}

// MARK: - View
protocol WorkshopListPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func reloadData()
}
