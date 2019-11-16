//
//  Capital.swift
//  CapitalCities-16
//
//  Created by Kamil Bloch on 17/06/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
