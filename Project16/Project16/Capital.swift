//
//  Capital.swift
//  Project16
//
//  Created by Erik Radicheski da Silva on 16/09/22.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String? , coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
