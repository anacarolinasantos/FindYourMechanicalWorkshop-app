//
//  WorkshopDetailRouter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopDetailRouterRouter: NSObject, WorkshopDetailRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "WorkshopDetail"
	private let viewIdentifier = "WorkshopDetailView"

	// MARK: - Viper Module Properties
	weak var view: WorkshopDetailView!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = WorkshopDetailInteractor()
		let presenter = WorkshopDetailPresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - WorkshopDetailRouterProtocol
    func push(from view: UIViewController) {
        
    }
    
    func dismiss() {
        
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> WorkshopDetailView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! WorkshopDetailView
	}
}
