//
//  Commit+CoreDataClass.swift
//  Project38 GithubCommits
//
//  Created by icedoutxcv on 26/09/2020.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }

}
