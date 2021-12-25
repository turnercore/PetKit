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
		newPetProfilePhoto.photo = UIImage(systemName: "photo")?.jpegData(compressionQuality: 1.0) ?? UIImage().pngData()
		newPetProfilePhoto.pet = newPet
		selectedPet = newPet
		save()
	}
	
	///Sets the profile photo for the pet, compressed to a 500k jpeg
	func setProfilePhoto(to photo: UIImage?, for pet: Pet) {
		let photo = photo ?? UIImage(systemName: "photo") ?? UIImage()
		let newProfilePhoto = ProfilePhoto(context: container.viewContext)
		
		//delete the current profile if htere is one
		//		if pet.profile != nil {
		//			deleteProfilePhoto(for: pet)
		//		}
		
		//Set up the pet relationship
		newProfilePhoto.pet = pet
		
		//Now we compress the image, and whenever that's done set the new image to the profile image.
		ImageCompressor.compress(image: photo, maxByte: 500000) { image in
			guard image != nil else {return}
			//change the profile photo to the compressed image
			newProfilePhoto.photo = self.createImageData(image)
		}
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
	
	///Creates image data safe to be saved in coredata, reduces the image size to 500kb before returning.
	func createImageData(_ image: UIImage?) -> Data { //This needs to be updated to a THROWS function to enable errors
		return image?.jpegData(compressionQuality: 1.0)
		?? UIImage(systemName: "photo")?.jpegData(compressionQuality: 1.0)
		?? UIImage().jpegData(compressionQuality: 1.0)!
		
		
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
		
		if pets.isEmpty {
			print("Adding a new default pet to database to prevent empty database")
			addNewPet()
		}
		
		initSelectedPet(pets: pets)
	}
	///Delete passed in weight data, update currentWeight, and updates the database
	func deleteWeightRecord(_ weightRecord: WeightRecord) {return}
	
	///Deleted the passed in size record, updates the database
	func deleteSizeRecord(_ sizeRecord: SizeRecord) {return}
	
	
	///Perform all the app startup tasks to make sure it doesn't crash on load
	func loadAppStartup(_ completion: @escaping () -> ()) {
		if pets.isEmpty {
			populateDefaultDatabase()
		}
		
		if selectedPet == Pet() {
			initSelectedPet(pets: pets)
		}
		
		completion()
	}
}

extension DataController: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let fetchedPets = controller.fetchedObjects as? [Pet]
		else { return }
		pets = fetchedPets
	}
}
