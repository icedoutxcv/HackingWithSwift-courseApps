//
//  Whistle.swift
//  Project33-WhatsThatWhistle
//
//  Created by icedoutxcv on 01/08/2020.
//

import Foundation
import CloudKit
import UIKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
