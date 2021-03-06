//
//  Petition.swift
//  Whitehouse-7
//
//  Created by Kamil Bloch on 03/04/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
