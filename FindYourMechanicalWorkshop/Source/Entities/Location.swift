//
//  Location.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 03/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let latitude : Double
    let longitude : Double
    
    enum CodingKeys : String, CodingKey {
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    init(_ lat: Double, _ lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let location = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        latitude = try location.decode(Double.self, forKey: .latitude)
        longitude = try location.decode(Double.self, forKey: .longitude)
    }
}
