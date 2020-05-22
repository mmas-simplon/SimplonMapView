//
//  Refuge.swift
//  SimplonMapView
//
//  Created by Mickael Mas on 20/05/2020.
//  Copyright © 2020 APPIWEDIA. All rights reserved.
//

import Foundation
import MapKit

class RefugeAnnotation: NSObject, MKAnnotation, Identifiable {
    var id = UUID()
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var type: Refuge.RefugeType
    
    override init() {
        self.coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        self.title = ""
        self.subtitle = ""
        self.type = .restauration
        super.init()
    }
    
    init(refuge: Refuge) {
        self.title = refuge.name
        self.subtitle = refuge.adresse
        self.coordinate = CLLocationCoordinate2D(latitude: refuge.latitude, longitude: refuge.longitude)
        self.type = refuge.type
    }
}
