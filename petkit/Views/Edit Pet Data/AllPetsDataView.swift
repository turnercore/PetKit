//
//  AllPetsDataView.swift
//  petkit
//
//  Created by Turner Monroe on 12/14/21.
//

import Foundation
import CoreData
import SwiftUI

struct AllPetsDataView: View {
	// @Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }


	var body: some View {
		NavigationView {
			List {
				ForEach(pets, id: \.self) {pet in
					NavigationLink("\(pet.name ?? "")") {
						SelectedPetDataView(pet: pet)
					}
				}
				.onDelete(perform: removePet)
				.toolbar {
					ToolbarItem(placement: .automatic) {
						Button("Done"){
							presentationMode.wrappedValue.dismiss()
						}
					}
				}
			}
			.navigationTitle("Pets")
		}
	}
	
	func removePet(at offsets: IndexSet) {
		for index in offsets {
			let pet = pets[index]
			dataController.deletePet(pet)
		}
	}
}
