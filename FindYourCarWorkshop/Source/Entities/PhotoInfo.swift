//
//  PhotoInfo.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 04/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct PhotoInfo: Decodable {
    
    let height : Int
    let width : Int
    let reference : String
    
    enum CodingKeys : String, CodingKey {
        case reference = "photo_reference"
        case height
        case width
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decode(Int.self, forKey: CodingKeys.height)
        width = try values.decode(Int.self, forKey: CodingKeys.width)
        reference = try values.decode(String.self, forKey: CodingKeys.reference)
    }
}
