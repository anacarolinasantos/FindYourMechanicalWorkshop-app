//
//  CarWorkshopTableViewCell.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 03/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import UIKit
import Reusable

final class CarWorkshopTableViewCell: UITableViewCell, Reusable {

    // MARK: - Outlets
    @IBOutlet weak var carWorkshopNameLabel: UILabel!
    @IBOutlet weak var carWorkshopImage: UIImageView!
    @IBOutlet weak var carWorkshopPriceLevelLabel: UILabel!
    @IBOutlet weak var carWorkshopRatingLabel: UILabel!
    
    // MARK: - Setup Cell
    func setup(with workshop: Workshop) {
        carWorkshopNameLabel.text = workshop.name
        
        guard let rating = workshop.rating else {
//            remove(view: carWorkshopRatingLabel)
            return
        }
        carWorkshopRatingLabel.text = String(rating)
        
        guard let priceLevel = workshop.priceLevel else {
//            remove(view: carWorkshopPriceLevelLabel)
            return
        }
        carWorkshopPriceLevelLabel.text = createPriceLevel(with: priceLevel)
    }
    
    // MARK: - Private Methods
    private func remove(view: UIView) {
        view.removeFromSuperview()
        layoutIfNeeded()
    }
    
    private func createPriceLevel(with level: Int) -> String {
        
        
        if level == 0 {
            return "Free"
        } else {
            var priceLevel = String()
            
            for _ in 1...level {
                priceLevel += "$"
            }
            
            return priceLevel
        }
        
        
    }
}
