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

final class DataController {
	
	
	
//	let persistenceController = PersistenceController.shared
	var viewContext: NSManagedObjectContext
//	{
//		persistenceController.container.viewContext
//	}

//	init (viewContext: NSManagedObjectContext) {
//		var viewContext = viewContext
//	}
	
	required init(context: NSManagedObjectContext) {
		viewContext = context
	}
	
	func addNewPet() {
		let newPet = Pet(context: viewContext)
		let newPetPrefs = Widgets(context: viewContext)
		newPet.widgets = newPetPrefs
		newPetPrefs.pet = newPet
		self.save()
	}
	func setProfilePicture(picture: UIImage?, for pet: Pet) {
		let unwrappedPicture = picture ?? UIImage(systemName: "photo") ?? UIImage()
		//var currentProfilePicture: UIImage
		for photo in pet.photosArray {
			photo.profile = false
		}
		let newProfilePicture = PetPhoto(context: viewContext)
		newProfilePicture.photo = unwrappedPicture.pngData() ?? UIImage(systemName: "photo")?.pngData()
		newProfilePicture.profile = true
		newProfilePicture.pet = pet
		self.save()
	}
	func getSelectedPet(in pets: FetchedResults<Pet>) -> Pet {
		var selectedPet: Pet?
		
		for pet in pets {
			if pet.selected == true {
				selectedPet = pet
				break
			} else {
				selectedPet = pet
			}
		}
		
		return selectedPet ?? Pet()
	}
	func changeSelectedPetTo(pet: Pet, in pets: FetchedResults<Pet>) {
		for selectedPet in pets {
			selectedPet.selected = false
		}
		pet.selected = true
		
		self.save()
	}
	func getPetsArrayFrom(fetchedPets: FetchedResults<Pet>) -> [Pet] {
		var petsArray: [Pet] = []
		
		
		for pet in fetchedPets {
			petsArray.append(pet)
		}
		
		return petsArray
	}
	func populateDefaultDatabase() {
		addNewPet()
		print("First Run, populating database with default pet data")
	}

	//Saves changes to database and provides errorhandling
	//TODO: ERROR HANDELING
	func save() {
		do {
			try viewContext.save()
			print("Saved Data")
		} catch let error as NSError {
			debugPrint(error)
			print("Error saving data")
		}
	}
	
	func deletePet(pet: Pet, allPets: FetchedResults<Pet> ) {
		var numberOfPets = 0
		var onlyOnePetInDatabase = true
		
		for _ in allPets {
			numberOfPets += 1
		}
		
		if numberOfPets > 1 {
			onlyOnePetInDatabase = false
		}
		
		if onlyOnePetInDatabase {
			print("Adding a new default pet to database to prevent empty database")
			addNewPet()
			save()
		}
		//do {
			viewContext.delete(pet)
			print("Deleted \(pet.wrappedName)")
		//} catch let error as NSError {
		//	debugPrint(error)
		//	print("Error deleting pet")
		//}
	}
	
}
