//
//  Trick+CoreDataProperties.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//
//

import Foundation
import CoreData


extension Trick {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trick> {
        return NSFetchRequest<Trick>(entityName: "Trick")
    }

    @NSManaged public var name: String?
    @NSManaged public var learnedDate: Date?
    @NSManaged public var command: String?
    @NSManaged public var notes: String?
    @NSManaged public var mastery: Int16
    @NSManaged public var pets: NSSet?

}

// MARK: Generated accessors for pets
extension Trick {

    @objc(addPetsObject:)
    @NSManaged public func addToPets(_ value: Pet)

    @objc(removePetsObject:)
    @NSManaged public func removeFromPets(_ value: Pet)

    @objc(addPets:)
    @NSManaged public func addToPets(_ values: NSSet)

    @objc(removePets:)
    @NSManaged public func removeFromPets(_ values: NSSet)

}

extension Trick : Identifiable {

}
