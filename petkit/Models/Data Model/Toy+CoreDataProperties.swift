//
//  Toy+CoreDataProperties.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//
//

import Foundation
import CoreData


extension Toy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Toy> {
        return NSFetchRequest<Toy>(entityName: "Toy")
    }

    @NSManaged public var name: String?
    @NSManaged public var whereBought: String?
    @NSManaged public var pet: Pet?

}

extension Toy : Identifiable {

}
