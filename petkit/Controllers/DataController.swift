//
//  Data.swift
//  petkit
//
//  Created by Turner Monroe on 12/13/21.
////
//
import Combine
import SwiftUI
import Foundation
import CoreData

extension Pet {
  static var petFetchRequest: NSFetchRequest<Pet> {
	let request: NSFetchRequest<Pet> = Pet.fetchRequest()
	//request.predicate = NSPredicate()
	request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

	return request
  }
}

final class DataController: NSObject, ObservableObject {
	let clearDataBaseAndRestart = false
	
	let viewContext: NSManagedObjectContext
	
	@Published var pets: [Pet] = []
	
	@Published var selectedPet: Pet = Pet()

	
	func setSelectedPet(to pet: Pet) {
		selectedPet.selected = false
		pet.selected = true
		selectedPet = pet
	}
	
	private let fetchPetsController: NSFetchedResultsController<Pet>

	
	required init(context: NSManagedObjectContext) {
		viewContext = context
		fetchPetsController = NSFetchedResultsController(fetchRequest:
												Pet.petFetchRequest,
											managedObjectContext: viewContext,
											sectionNameKeyPath: nil,
											cacheName: nil)
		super.init()
		fetchPetsController.delegate = self
		
		do {
			  try fetchPetsController.performFetch()
			  pets = fetchPetsController.fetchedObjects ?? []
			} catch {
			  print("failed to fetch items!")
			}
		
		for pet in pets {
			   if pet.selected == true {
				   selectedPet = pet
				   break
			   } else {
			   guard let firstPet = pets.first
			   else {
				   addNewPet()
				   break
			   }
				   selectedPet = firstPet
			   }
		   }
	}
	
	func addNewPet() {
		let newPet = Pet(context: self.viewContext)
		let newPetPrefs = Widgets(context: self.viewContext)
		let newPetProfilePhoto = ProfilePhoto(context: self.viewContext)
		newPet.widgets = newPetPrefs
		newPetPrefs.pet = newPet
		newPetProfilePhoto.photo = UIImage(systemName: "photo")?.pngData() ?? UIImage().pngData()
		newPetProfilePhoto.pet = newPet
	}
	
	func setProfilePicture(picture: UIImage?, for pet: Pet) {
		let unwrappedPicture = picture ?? UIImage(systemName: "photo") ?? UIImage()
		let newProfilePicture = ProfilePhoto(context: viewContext)
		
		if pet.profile != nil {
			deleteProfilePhoto(for: pet)
		}
		
		newProfilePicture.photo = unwrappedPicture.pngData() ?? UIImage(systemName: "photo")?.pngData()
		newProfilePicture.pet = pet
		self.save()
	}
	
	func deleteProfilePhoto(for pet: Pet){
		viewContext.delete(pet.profile!)
	}

	func changeSelectedPetTo(pet: Pet) {
		selectedPet.selected = false
		pet.selected = true
	}
	
	func populateDefaultDatabase() {
		addNewPet()
		save()
		print("Populating database with default pet data")
	}

	///Saves changes to database and provides errorhandling
	func save() {
		//TODO: ERROR HANDELING
		do {
			try self.viewContext.save()
			print("Saved Data")
		} catch let error as NSError {
			debugPrint(error)
			print("Error saving data")
		}
	}
	
	func deletePet(_ petToDelete: Pet) {
//		var noPetSelected: Bool = false
		
		self.viewContext.delete(petToDelete)
		
		for (index, pet) in pets.enumerated() {
			if pet == petToDelete {
				pets.remove(at: index)
			}
		}

		print(pets)
		
		if pets == [] {
			print("Adding a new default pet to database to prevent empty database")
			addNewPet()
			//populateDefaultDatabase()
		}
	}
}

extension DataController: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
	guard let fetchedPets = controller.fetchedObjects as? [Pet]
	  else { return }

	pets = fetchedPets
  }
}
