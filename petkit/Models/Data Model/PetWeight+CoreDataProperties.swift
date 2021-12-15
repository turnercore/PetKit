//
//  PetWeight+CoreDataProperties.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//
//

import Foundation
import CoreData


extension PetWeight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetWeight> {
        return NSFetchRequest<PetWeight>(entityName: "PetWeight")
    }

    @NSManaged public var petWeight: Double
    @NSManaged public var weightDate: Date
    @NSManaged public var lbs: Bool
    @NSManaged public var pet: Pet?

}

extension PetWeight : Identifiable {

}
