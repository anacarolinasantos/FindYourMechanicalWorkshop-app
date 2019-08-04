//
//  WorkshopDetailView.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 04/08/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class WorkshopDetailView: UIViewController, WorkshopDetailPresenterOutputProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!

	// MARK: - Viper Module Properties
	var presenter: WorkshopDetailPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    // MARK: - WorkshopDetailPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func loadData(title: String) {
        self.title = title
//        addressLabel.text = presenter.workshop.address
//        detailLabel.text = presenter.workshop.address + presenter.workshop.name
        
//        let location = CLLocationCoordinate2D(latitude: presenter.workshop.geometry.latitude, longitude: presenter.workshop.geometry.longitude)
        
        let marker = GMSMarker()
//        marker.position = location
//        marker.title = presenter.workshop.name
//        marker.snippet = presenter.workshop.address
        marker.map = mapView
        
//        mapView.animate(toLocation: location)
        mapView.animate(toZoom: 16)
    }

    func presentMapsOption() {
//        let actionSheet = UIAlertController(title: nil, message: "Escolha um dos apps de mapa", preferredStyle: .actionSheet)
//        let location = CLLocationCoordinate2D(latitude: presenter.workshop.geometry.latitude, longitude: presenter.workshop.geometry.longitude)
        //Waze
//        if let url = URL(string: "waze://app"),
//            UIApplication.shared.canOpenURL(url){
//            let action = UIAlertAction(title: "Waze", style: .default) { (action) in
//                guard let url = URL(string:"https://waze.com/ul?q=ll=\(location.latitude),\(location.longitude)&navigate=yes") else {return}
//                UIApplication.shared.open(url)
//            }
//            actionSheet.addAction(action)
//        }
        
        //Google Maps
//        if let url = URL(string: "comgooglemaps://app"),
//            UIApplication.shared.canOpenURL(url){
//            let action = UIAlertAction(title: "Google Maps", style: .default) { (action) in
//                guard let url = URL(string:"comgooglemaps://?daddr=\(location.latitude),\(location.longitude)&directionsmode=transit") else {return}
//                UIApplication.shared.open(url)
//            }
//            actionSheet.addAction(action)
//        }
        
//        if actionSheet.actions.count > 0 {
//            //Apple Maps
//            let action = UIAlertAction(title: "Maps", style: .default) { (action) in
//                let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
//                destination.name = self.presenter.workshop.name
//
//                MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//            }
//            actionSheet.addAction(action)
//
//            self.present(actionSheet, animated: true, completion: nil)
//        }else{
//            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
//            destination.name = self.presenter.workshop.name
//            
//            MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//        }
        
        
    }
    
	// MARK: - Private Methods
    private func prepareViewController() {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Actions
    @IBAction func tapGoTo(_ sender: UIButton) {
        // Open and show coordinate
        self.presenter.showMapsLaunchOption()
    }
}
