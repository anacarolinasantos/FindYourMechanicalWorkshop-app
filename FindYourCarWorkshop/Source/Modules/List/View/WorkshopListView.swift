//
//  WorkshopListView.swift
//  FindYourMechanicalWorkshop
//
//  Created Ana Carolina Silva on 26/07/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class WorkshopListView: UIViewController, WorkshopListPresenterOutputProtocol, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Properties
    private let kEmptyTableViewCellIdentifier = "EmptyTableViewCell"
    private let kTitleList = "Oficinas de Carro"
    
    private var vSpinner : UIView?

	// MARK: - Viper Module Properties
	var presenter: WorkshopListPresenterInputProtocol!

	// MARK: - Override Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        presenter.viewDidLoad()
    }

    // MARK: - WorkshopListPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        if loading {
            showSpinner()
        } else {
            removeSpinner()
        }
    }
    
    func showError(message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        listTableView.reloadData()
    }

	// MARK: - Private Methods
    private func prepareViewController() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = kTitleList
        listTableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        listTableView.dataSource = self
        listTableView.delegate = self
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

    // MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CarWorkshopTableViewCell
        cell.setup(with: presenter.item(at: indexPath.row), photoURL: presenter.getPhotoURL(at: indexPath.row))
        
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
