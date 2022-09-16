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
    var url: URL!
    
    init(title: String? , coordinate: CLLocationCoordinate2D, url: String) {
        self.title = title
        self.coordinate = coordinate
        self.url = URL(string: url)
    }
    
}
