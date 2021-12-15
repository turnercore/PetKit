//
//  Poop+CoreDataProperties.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//
//

import Foundation
import CoreData


extension Poop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Poop> {
        return NSFetchRequest<Poop>(entityName: "Poop")
    }

    @NSManaged public var quality: Int16
    @NSManaged public var poopDate: Date?
    @NSManaged public var photo: Data?
    @NSManaged public var pet: Pet?

}

extension Poop : Identifiable {

}
