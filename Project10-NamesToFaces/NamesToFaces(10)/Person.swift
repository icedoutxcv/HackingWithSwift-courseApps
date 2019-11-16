//
//  Person.swift
//  NamesToFaces(10)
//
//  Created by Kamil Bloch on 10/04/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
