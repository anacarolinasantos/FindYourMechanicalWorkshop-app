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
}

// MARK: - Interactor
protocol WorkshopListInteractorInputProtocol {

}

// MARK: - Presenter
protocol WorkshopListPresenterInputProtocol: class {

}

protocol WorkshopListInteractorOutputProtocol: class {

}

// MARK: - View
protocol WorkshopListPresenterOutputProtocol: class {

}
