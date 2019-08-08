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
    @IBOutlet private weak var carWorkshopImageView: UIImageView!
    @IBOutlet private weak var carWorkshopRatingLabel: UILabel!
    @IBOutlet private weak var carWorkshopAddressLabel: UILabel!
    @IBOutlet private weak var carWorkshopPhoneLabel: UILabel!
    @IBOutlet private weak var mapView: GMSMapView!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private let kPlaceholderImageName = "placeholder-image"
    private let kZoom: Float = 15.0
    
    private var vSpinner : UIView?

	// MARK: - Viper Module Properties
	var presenter: WorkshopDetailPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        presenter.viewDidLoad()
    }

    // MARK: - WorkshopDetailPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        if loading {
            showSpinner()
        } else {
            removeSpinner()
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func loadData(with workshop: Workshop) {
        title = workshop.name
        
        if let photoURL = presenter.getPhotoURL() {
            loadImageView(with: photoURL)
        } else {
            imageViewHeightConstraint.constant = 0
            carWorkshopImageView.isHidden = true
        }
        
        if let rating = workshop.rating {
            carWorkshopRatingLabel.text = String(rating)
        } else {
            carWorkshopRatingLabel.isHidden = true
        }
        
        carWorkshopAddressLabel.text = workshop.formattedAddress ?? workshop.address
        loadPhoneLabel(workshop.formattedPhoneNumber)
    }
    
    func addMapMarker(with marker: GMSMarker) {
        marker.map = mapView
        mapView.animate(toLocation: marker.position)
        mapView.animate(toZoom: kZoom)
    }
    
	// MARK: - Private Methods
    private func prepareViewController() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadImageView(with photoURL: String) {
        let url = URL(string: photoURL)
        carWorkshopImageView.kf.indicatorType = .activity
        carWorkshopImageView.kf.setImage(with: url)
    }
    
    private func loadPhoneLabel(_ string: String?) {
        guard let phone = string else {
            phoneStackView.isHidden = true
            return
        }
        carWorkshopPhoneLabel.text = phone
    }
    
    private func showSpinner() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    private func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
