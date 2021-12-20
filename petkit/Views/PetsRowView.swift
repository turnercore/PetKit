//
//  PetsRowView.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//

import SwiftUI
import CoreData
import UIKit


struct PetsRowView: View {
	var pets: FetchedResults<Pet>
	
	var body: some View {
			ZStack {
				Color("SecondaryColor")
				
				ScrollView (.horizontal){
					LazyHStack {
						ForEach(pets) {pet in
							PetProfileButton(pet: pet)
								.frame(minWidth: 80)
						}
					}
					.padding(.leading, 100)
				}
			}
	}
}


struct PetsColumnView: View {
	var pets: FetchedResults<Pet>
	
	var body: some View {
		ZStack {
			Color("SecondaryColor")
			
			ScrollView (.vertical){
				LazyVStack {
					ForEach(pets) {pet in
						PetProfileButton(pet: pet)
							.frame(minWidth: 100)
							.padding()
					}
				}
			}
		}
	}
}

struct PetProfileButton: View {
	let pet: Pet
	@EnvironmentObject var dataController: DataController

	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
	
	
	
	var body: some View {
		VStack {
			Button {
				dataController.changeSelectedPetTo(pet: pet, in: pets)
				
			} label: {
				ForEach(pet.photosArray) { photo in
					if photo.profile == true {
						Image(uiImage: UIImage(data: photo.wrappedPhoto)!)
							.resizable()
							.frame(minWidth: 75, minHeight: 75)
							.scaledToFit()
							.clipShape(Circle())
						//This code might be dangerous ***Danger***
					}
					
				}
			}
			
			Text(pet.wrappedName)
				.font(.caption)
				.kerning(Style.kerning)
				.fontWeight(.semibold)
				.foregroundColor(Color("TextColor"))
				.multilineTextAlignment(.center)
		}.padding()
		
	}
}

struct PetsRowView_Previews: PreviewProvider {
	
	static var previews: some View {
		//        ContentView()
		//			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
		let context = PersistenceController.shared.container.viewContext
		return ContentView().environment(\.managedObjectContext, context)
	}
}
