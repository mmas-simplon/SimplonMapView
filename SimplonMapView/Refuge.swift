//
//  Refuge.swift
//  SimplonMapView
//
//  Created by Mickael Mas on 20/05/2020.
//  Copyright © 2020 APPIWEDIA. All rights reserved.
//

import Foundation

struct Refuge {
    var name: String
    var adresse: String
    var horaires: String
    var isOpen: Bool
    var type: RefugeType
    var latitude: Double
    var longitude: Double
    
    enum RefugeType: String {
        case restauration = "restauration"
        case nightClub = "nightClub"
    }
}
