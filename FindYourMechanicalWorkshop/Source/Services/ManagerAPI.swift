//
//  ManagerAPI.swift
//  FindYourMechanicalWorkshop
//
//  Created by Ana Carolina Silva on 31/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import Foundation

final class ManagerAPI {
    
    // MARK: - Static Reference
    
    static let shared = ManagerAPI()
    
    // MARK: - Private Properties
    
    private let persistencyManager = PersistencyManager()
    private let httpClient = GoogleAPIClient()
    private let isOnline = false
    
    // MARK: - Private Initializer
    
    private init() {
        
    }
    
    // MARK: - Public Methods
    
}
