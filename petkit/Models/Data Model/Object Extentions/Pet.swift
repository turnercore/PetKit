//
//  SwiftUIView.swift
//  petkit
//
//  Created by Turner Monroe on 12/12/21.
//

import Foundation
import CoreData
import SwiftUI

//Extentions to create safely unwrapped optionals from the coredata model to use in the rest of the code without having to upwrap them constantly
extension Pet {
	
	public var wrappedName: String {
		get { name ?? "Unknown Name"}
		set { self.name = newValue }
	}
	
	public var wrappedProfilePhoto: Data {
		get {
			if profile == nil {
				return UIImage(systemName: "photo")?.pngData() ?? UIImage().pngData()!
			} else if profile!.photo == nil {
				return UIImage(systemName: "photo")?.jpegData(compressionQuality: 1.0) ?? UIImage().jpegData(compressionQuality: 1.0)!
			} else {
				return self.profile!.photo!
			}
		}
		set { self.profile?.photo = newValue }
		
	}
}


//Some code to help setting up the pet fetch request, a little unclear to me how this works, but it seemx needed
extension Pet {
  static var petFetchRequest: NSFetchRequest<Pet> {
	let request: NSFetchRequest<Pet> = Pet.fetchRequest()
	//request.predicate = NSPredicate()
	request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

	return request
  }
}
