//
//  Workshop.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 01/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct Workshop: Decodable {
    
    let id: String
    let geometry: Location
    let name: String
    let photos: [PhotoInfo]?
    let address: String
    let rating: Double?
    let priceLevel: Int?
    
    enum CodingKeys : String, CodingKey {
        case geometry = "geometry"
        case name = "name"
        case address = "vicinity"
        case id = "place_id"
        case priceLevel = "price_level"
        case rating
        case photos
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        geometry = try values.decode(Location.self, forKey: .geometry)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        id = try values.decode(String.self, forKey: .id)
        photos = try? values.decode([PhotoInfo].self, forKey: .photos)
        rating = try? values.decode(Double.self, forKey: .rating)
        priceLevel = try? values.decode(Int.self, forKey: .priceLevel)
    }
}
