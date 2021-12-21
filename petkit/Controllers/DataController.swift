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

final class DataController: NSObject, ObservableObject {
	///Singleton variable, setting this as the environment variable so it can be accessed there within the views
	static let shared = DataController()
	
	//testing veriable that will clear all entities in the database and start fresh, used to clear the database for testing if there are errors (NOT FUNCTIONAL CURRENTLY)
	let clearDataBaseAndRestart = false
	
	//Published variables (almost everything is collected within the pets array, the selectedPet variable is just for convience
	@Published var pets: [Pet] = []
	@Published var selectedPet: Pet = Pet()
	//Selected pet could have a didSet function that makes sure the pet array is updated and the database is saved
	
	
	//Variables related to persistance and cloud storage
	private let fetchPetsController: NSFetchedResultsController<Pet>
	let persistanceController = PersistenceController.shared
	public var container: NSPersistentCloudKitContainer
	
	///Singleton Init
	override private init() {
		
		print("STRTING DATA CONTROLLER ................ \n \n \n \n ..................>!")
		
		container = persistanceController.container
		
		fetchPetsController = NSFetchedResultsController(fetchRequest:
															Pet.petFetchRequest,
														 managedObjectContext: container.viewContext,
														 sectionNameKeyPath: nil,
														 cacheName: nil)
		super.init()
		
		fetchPetsController.delegate = self
		
		fetchAllPets()
		
		initSelectedPet(pets: pets)
	}
	
	func initSelectedPet(pets: [Pet]) {
		for pet in pets {
			if pet.selected {
				selectedPet = pet
				print("Found a selected pet")
				return
			}
		}
		//If the for loop finds no selected pets:
		guard let firstPet = pets.first
		else {
			addNewPet()
			print("No Pets found... adding new pet.")
			return
		}
		
		selectedPet = firstPet
		print("No selected pet found, setting to first pet in array. SET SELECTED PET \(selectedPet.name ?? "NO NAME")")
	}
	///Fetches all the pet records from the database, uses iCloud if avaiailable, and coredata if not
	func fetchAllPets() {
		//Change this to a proper throw, async and make sure it's running in the background. (maybe on the background)
		do {
			try fetchPetsController.performFetch()
			pets = fetchPetsController.fetchedObjects ?? []
		} catch {
			print("Failed to fetch items! BLAH WHAT IS GOING ON!?")
		}
	}
	///Adds a new default pet to the database, needs to be refactored to accept input so it can be used on the add a pet page
	func addNewPet() {
		let newPet = Pet(context: self.container.viewContext)
		let newPetPrefs = Preferences(context: self.container.viewContext)
		let newPetProfilePhoto = ProfilePhoto(context: self.container.viewContext)
		newPet.preferences = newPetPrefs
		newPetPrefs.pet = newPet
		newPetProfilePhoto.photo = UIImage(systemName: "photo")?.pngData() ?? UIImage().pngData()
		newPetProfilePhoto.pet = newPet
	}
	//TODO: REFACTOR THE PROFILE PHOTO IMAGES TO BE MUCH SMALLER, THIS IS SLOWING DOWN THE APP LOADING WHEN PICTURES ARE INVOLVED
	//ALTERNATIVELY MAKE THE PHOTO A URI
	///Sets the profile photo for the pet
	func setProfilePicture(picture: UIImage?, for pet: Pet) {
		let unwrappedPicture = picture ?? UIImage(systemName: "photo") ?? UIImage()
		let newProfilePicture = ProfilePhoto(context: container.viewContext)
		
		if pet.profile != nil {
			deleteProfilePhoto(for: pet)
		}
		
		newProfilePicture.photo = unwrappedPicture.pngData() ?? UIImage(systemName: "photo")?.pngData()
		newProfilePicture.pet = pet
		self.save()
	}
	///Updates the selected pet FROM the old pet TO the new pet
	func setSelectedPet(to pet: Pet) {
		selectedPet.selected = false
		pet.selected = true
		selectedPet = pet
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
			try self.container.viewContext.save()
			print("Saved Data")
		} catch let error as NSError {
			debugPrint(error)
			print("Error saving data")
		}
	}

	///Deletes a pet and updates the database and the controller.
	func deletePet(_ petToDelete: Pet) {
		//		var noPetSelected: Bool = false
		
		self.container.viewContext.delete(petToDelete)
		
		
		//This is supposed to update the pets array to reflect the changes in the database (aka removing the deleted pet), it may be better to just do another fetch request, I'm very not sure.
		for (index, pet) in pets.enumerated() {
			if pet == petToDelete {
				pets.remove(at: index)
			}
		}
				
		if pets == [] {
			print("Adding a new default pet to database to prevent empty database")
			addNewPet()
			//populateDefaultDatabase()
		}
		
		initSelectedPet(pets: pets)
	}
	///Delete passed in weight data, update currentWeight, and updates the database
	func deleteWeight(_ weightRecord: Weight) {return}
	///Deleted the passed in size record, updates the database
	func deleteSize(_ sizeRecord: Size) {return}
	///Set the profile photo to a default profile photo and removes the data
	func deleteProfilePhoto(for pet: Pet){
		container.viewContext.delete(pet.profile!)
	}

}

extension DataController: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let fetchedPets = controller.fetchedObjects as? [Pet]
		else { return }
		
		pets = fetchedPets
	}
}
