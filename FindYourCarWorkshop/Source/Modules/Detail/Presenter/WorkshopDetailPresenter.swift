//
//  WorkshopDetailPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import GoogleMaps

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
    
    func getPhotoURL() -> String? {
        if let photos = workshop.photos {
            return interactor.getPhotoURL(with: photos[0].reference, maxWidth: Int(UIScreen.main.bounds.width))
        }
        return nil
    }

    // MARK: - WorkshopDetailPresenterInteractorOutputProtocol
    func handleSuccess(with result: Workshop) {
        view.showLoading(false)
        workshop = result
        view.loadData(with: workshop)
        view.addMapMarker(with: getCarWorkshopMarker())
    }
    
    func handleFailure(with message: String) {
        view.showLoading(false)
        view.showError(message: message)
    }

	// MARK: - Private Methods
    private func getCarWorkshopMarker() -> GMSMarker {
        let location = CLLocationCoordinate2D(latitude: workshop.geometry.latitude, longitude: workshop.geometry.longitude)
        
        let marker = GMSMarker()
        marker.position = location
        marker.title = workshop.name
        marker.snippet = workshop.address
        
        return marker
    }
}
