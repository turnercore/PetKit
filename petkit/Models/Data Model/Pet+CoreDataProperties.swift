//
//  Pet+CoreDataProperties.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var poops: NSSet?
    @NSManaged public var petWeight: NSSet?
    @NSManaged public var tricks: NSSet?
    @NSManaged public var toys: NSSet?
	
	public var weightsArray: [PetWeight] {
		let set = petWeight as? Set<PetWeight> ?? []
		return set.sorted {
			$0.weightDate < $1.weightDate
		}
	}

}

// MARK: Generated accessors for poops
extension Pet {

    @objc(addPoopsObject:)
    @NSManaged public func addToPoops(_ value: Poop)

    @objc(removePoopsObject:)
    @NSManaged public func removeFromPoops(_ value: Poop)

    @objc(addPoops:)
    @NSManaged public func addToPoops(_ values: NSSet)

    @objc(removePoops:)
    @NSManaged public func removeFromPoops(_ values: NSSet)

}

// MARK: Generated accessors for petWeight
extension Pet {

    @objc(addPetWeightObject:)
    @NSManaged public func addToPetWeight(_ value: PetWeight)

    @objc(removePetWeightObject:)
    @NSManaged public func removeFromPetWeight(_ value: PetWeight)

    @objc(addPetWeight:)
    @NSManaged public func addToPetWeight(_ values: NSSet)

    @objc(removePetWeight:)
    @NSManaged public func removeFromPetWeight(_ values: NSSet)

}

// MARK: Generated accessors for tricks
extension Pet {

    @objc(addTricksObject:)
    @NSManaged public func addToTricks(_ value: Trick)

    @objc(removeTricksObject:)
    @NSManaged public func removeFromTricks(_ value: Trick)

    @objc(addTricks:)
    @NSManaged public func addToTricks(_ values: NSSet)

    @objc(removeTricks:)
    @NSManaged public func removeFromTricks(_ values: NSSet)

}

// MARK: Generated accessors for toys
extension Pet {

    @objc(addToysObject:)
    @NSManaged public func addToToys(_ value: Toy)

    @objc(removeToysObject:)
    @NSManaged public func removeFromToys(_ value: Toy)

    @objc(addToys:)
    @NSManaged public func addToToys(_ values: NSSet)

    @objc(removeToys:)
    @NSManaged public func removeFromToys(_ values: NSSet)

}

extension Pet : Identifiable {

}

//MARK: Pet Save/Load/Delete Functions
extension Pet {
	func deletePet(context: NSManagedObjectContext) {
		let viewContext = context
		viewContext.delete(self)
	 // save the context
		try? viewContext.save()
 }
}
