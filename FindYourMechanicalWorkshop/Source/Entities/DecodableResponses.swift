//
//  DecodableResponses.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 03/08/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

struct GooglePlaceResults<T: Decodable>: Decodable {
    let results: [T]
}
