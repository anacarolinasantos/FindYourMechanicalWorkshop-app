//
//  WorkshopListPresenter.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import CoreLocation

class WorkshopListPresenter: NSObject, WorkshopListPresenterInputProtocol, WorkshopListInteractorOutputProtocol, CLLocationManagerDelegate {

    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private var workshops: [Workshop] = []
    
    private let kMaxImageWidth = 70
    
    private var currentLatitude = -23.593858
    private var currentLongitude = -46.679999
    
	// MARK: - Viper Module Properties
    weak var view: WorkshopListPresenterOutputProtocol!
    var interactor: WorkshopListInteractorInputProtocol!
    var router: WorkshopListRouterProtocol!

    // MARK: - WorkshopListPresenterInputProtocol
    func viewDidLoad() {
        self.locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
        
        view.showLoading(true)
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
    
    func getPhotoURL(at indexPath: Int) -> String? {
        if let photos = workshops[indexPath].photos {
            return interactor.getPhotoURL(with: photos[0].reference, maxWidth: kMaxImageWidth)
        }
        return nil
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
    private func fetchCarWorkshopList() {
        interactor.fetchCarWorkshopList(near: Location(currentLatitude, currentLongitude))
    }
    
    // MARK: - Core Location Manager Delegate
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        view.showError(message: "Error trying to get current location")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        currentLatitude = userLocation.coordinate.latitude
        currentLongitude = userLocation.coordinate.longitude
        
        locationManager.stopUpdatingLocation()
        fetchCarWorkshopList()
    }
}
