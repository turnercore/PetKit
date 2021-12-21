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
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }
	
	var body: some View {
		ZStack {
			Color("SecondaryColor")
			
			ScrollView (.horizontal){
				LazyHStack {
					ForEach(pets) {pet in
						PetProfileButton(pet: pet)
							.frame(minWidth: pet.selected ? 90 : 80)
							.shadow(color: pet.selected
									? Color("PopColor")
									: Color(.clear),
									radius: Style.shadowRadius,
									x: Style.shadowOffsetX,
									y: Style.shadowOffsetY)
					}
				}
				.padding(.leading, 100)
			}
		}
	}
}


struct PetsColumnView: View {
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }
	var body: some View {
		ZStack {
			Color("SecondaryColor")
			
			ScrollView (.vertical){
				LazyVStack {
					ForEach(pets) {pet in
						PetProfileButton(pet: pet)
							.frame(minWidth: pet.selected ? 120 : 100)
							.padding()
							.shadow(color: pet.selected
									? Color("PopColor")
									: Color(.clear),
									radius: Style.shadowRadius,
									x: Style.shadowOffsetX,
									y: Style.shadowOffsetY)
					}
				}
			}
		}
	}
}

struct PetProfileButton: View {
	let pet: Pet
	// @Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }
	
	
	
	var body: some View {
		VStack {
			Button {
				dataController.setSelectedPet(to: pet)
			} label: {
				Image(uiImage: UIImage(data: pet.wrappedProfilePhoto) ?? UIImage(systemName: "photo")!)
					.resizable()
					.frame(minWidth: 75, minHeight: 75)
					.scaledToFit()
					.clipShape(Circle())
			}
			Text(pet.wrappedName)
				.font(.title)
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
