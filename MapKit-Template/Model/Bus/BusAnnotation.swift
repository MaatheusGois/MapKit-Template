//
//  Bus.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 21/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation
import MapKit

class BusAnnotation: NSObject, MKAnnotation {
    @objc dynamic var title: String?
    @objc dynamic var date: Date
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(title: String, date: Date,  coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.date = date
        self.coordinate = coordinate
        
        super.init()
    }
    // All your properties should be included
    enum CodingKeys: String, CodingKey {
        case title
        case date
        case coordinate   // this one was missing
    }
    
    var subtitle: String? {
        return "\(date)"
    }
}


