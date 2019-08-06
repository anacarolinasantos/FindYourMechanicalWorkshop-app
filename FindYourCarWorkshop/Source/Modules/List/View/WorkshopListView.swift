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
    
    // MARK: - Properties
    private let kEmptyTableViewCellIdentifier = "EmptyTableViewCell"
    
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
        
    }
    
    func showError(message: String) {
//        listTableView.re
        
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        listTableView.reloadData()
    }

	// MARK: - Private Methods
    func prepareViewController() {
        listTableView.dataSource = self
        listTableView.delegate = self
    }

    // MARK: - Action
    
    // MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CarWorkshopTableViewCell
        
        guard let workshop = presenter.item(at: indexPath.row) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kEmptyTableViewCellIdentifier, for: indexPath)
            return cell
        }
        
        cell.setup(with: workshop)
        
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
}
