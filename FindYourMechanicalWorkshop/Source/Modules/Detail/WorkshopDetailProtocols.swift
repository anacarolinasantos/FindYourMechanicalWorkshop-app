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
    func dismiss()
}

// MARK: - Interactor
protocol WorkshopDetailInteractorInputProtocol {

}

// MARK: - Presenter
protocol WorkshopDetailPresenterInputProtocol: class {

}

protocol WorkshopDetailInteractorOutputProtocol: class {

}

// MARK: - View
protocol WorkshopDetailPresenterOutputProtocol: class {

}
