//
//  Workshop.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 01/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct Workshop: Decodable {
    
    let geometry : Location //a
    let name : String
//    let openingHours : OpenNow? //b
//    let photos : [PhotoInfo] //c
    let address : String
    
    enum CodingKeys : String, CodingKey {
        case geometry = "geometry"
        case name = "name"
//        case openingHours = "opening_hours" //d
//        case photos = "photos"
        case address = "vicinity"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        geometry = try values.decode(Location.self, forKey: CodingKeys.geometry)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        address = try values.decode(String.self, forKey: CodingKeys.address)
    }
    
}
