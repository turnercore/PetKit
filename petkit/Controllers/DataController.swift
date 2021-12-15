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
	//@Environment(\.managedObjectContext) private var viewContext
	let persistenceController = PersistenceController.shared
	var viewContext: NSManagedObjectContext {
		persistenceController.container.viewContext
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

	func save () {
		do {
			try viewContext.save()
			print("Saved Data")
		} catch let error as NSError {
			debugPrint(error)
			print("Error saving data")
		}
	}
}
//
//class PetsArray: ObservableObject, random {
////	var pets: [Pet]
//	init(pets: [Pet]){
//		
//	}
//}
