//
//  WorkshopDetailProtocols.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

// MARK: - Router
protocol WorkshopDetailRouterProtocol: class {
    func push(from view: UIViewController)
}

// MARK: - Interactor
protocol WorkshopDetailInteractorInputProtocol {
    func fetchCarWorkshopDetail(with id: String)
}

// MARK: - Presenter
protocol WorkshopDetailPresenterInputProtocol: class {
    func viewDidLoad()
    func showMapsLaunchOption()
}

protocol WorkshopDetailInteractorOutputProtocol: class {
    func handleSuccess(with result: Workshop)
    func handleFailure(with message: String)
}

// MARK: - View
protocol WorkshopDetailPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func loadData(title: String)
    func presentMapsOption()
}
