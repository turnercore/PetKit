//
//  SwiftUIView.swift
//  petkit
//
//  Created by Turner Monroe on 12/12/21.
//

import Foundation
import CoreData
import SwiftUI


extension Pet {
	var context: NSManagedObjectContext {
		//@Environment(\.managedObjectContext) var viewContext
		//return viewContext
		PersistenceController.shared.container.viewContext
	}
	
	public var wrappedName: String {
		get { name ?? "Unknown Name"}
		set { self.name = newValue }
	}
	
	
	
	//Wrap NSSets to Arrays to be usable in SwiftUI
	public var weightsArray: [Weight] {
		get {
			let set = weightData as? Set<Weight> ?? []
			var array = set.sorted {
				$0.value < $1.value
			}
			if array == [] {
				array.append(Weight(context: context))
				array[0].pet = self
			}
			return array
		}
	}
	
//	public var widgetsArray: [Widgets] {
//		get {
//			var array: [Widgets] = []
//			widgets.flatMap { key, widget in
//				array.append(key, widget)
//				}
//			if array == [] {
//				let widgetSetup = Widgets(context: context)
//				self.widgets = widgetSetup
//			}
//			widgets.flatMap { widget in
//				array.append(widget)
//			}
//			return array
//		}
//		set {
//
//		}
//	}
	
	public var photosArray: [PetPhoto] {
		get {
			let set = photos as? Set<PetPhoto> ?? []
			var array = Array(set)
			if array == [] {
				array.append(PetPhoto(context: context))
				array[0].profile = true
				array[0].photo = UIImage(systemName: "SampleMarci")?.pngData()
				array[0].pet = self
			}
			return array
		}
	}
	
	//Useful "Current" value access aka last updated value

	public var profilePhoto: PetPhoto {
		for photo in photosArray {
			if photo.profile == true {
				return photo
			}
		}
		let profile = PetPhoto(context: context)
		profile.profile = true
		profile.photo = UIImage(systemName: "photo")?.pngData()
		return profile
	}
	
	public var currentWeight: Weight {
		guard let current = weightsArray.first
		else {
			print("Error, there was no weightsArray")
			return Weight(context: context)
		}
		return current
	}
}

//class DefaultPet: Pet {
//	convenience init(name: String = "New Pet",
//					 desc: String = "Default Pet",
//					 species: String = "Dog",
//					 breed: String = "Huskey",
//					 allergies: String = "None",
//					 selected: Bool = true
//	) {
//		self.init()
//		self.name = name
//		self.species = species
//		self.selected = selected
//		self.desc = desc
//		self.breed = breed
//		self.allergies = allergies
//
//		var defaultSizeArray: [Size] {
//			let sizeData: [Size] = [Size()]
//			sizeData[0].width = 0.0
//			sizeData[0].length = 0.0
//			sizeData[0].waist = 0.0
//
//			return sizeData
//		}
//		self.sizeData = NSSet(array: defaultSizeArray)
//
//		var defaultWeightsArray: [Weight] {
//			let weightData: [Weight] = [Weight()]
//			weightData[0].value = 0.0
//			weightData[0].lbs = true
//
//			return weightData
//		}
//		self.weightData = NSSet(array: defaultWeightsArray)
//	}
//}
