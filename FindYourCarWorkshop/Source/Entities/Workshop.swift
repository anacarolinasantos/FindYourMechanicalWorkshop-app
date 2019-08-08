//
//  Workshop.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 01/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct Workshop: Equatable, Decodable {
    
    let id: String
    let geometry: Location
    let name: String
    let photos: [PhotoInfo]?
    let address: String
    let formattedAddress: String?
    let formattedPhoneNumber: String?
    let rating: Double?
    
    enum CodingKeys : String, CodingKey {
        case address = "vicinity"
        case id = "place_id"
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case geometry
        case name
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
        formattedAddress = try? values.decode(String.self, forKey: .formattedAddress)
        formattedPhoneNumber = try? values.decode(String.self, forKey: .formattedPhoneNumber)
    }
    
    static func == (lhs: Workshop, rhs: Workshop) -> Bool {
        return lhs.id == rhs.id &&
            lhs.geometry == rhs.geometry &&
            lhs.name == lhs.name &&
            lhs.photos == rhs.photos &&
            lhs.address == rhs.address &&
            lhs.formattedAddress == rhs.formattedAddress &&
            lhs.formattedPhoneNumber == rhs.formattedPhoneNumber &&
            lhs.rating == rhs.rating
    }
}
