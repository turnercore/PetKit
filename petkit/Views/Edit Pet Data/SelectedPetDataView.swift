//
//  SelectedPetDataView.swift
//  petkit
//
//  Created by Turner Monroe on 12/14/21.
//

import Foundation
import CoreData
import SwiftUI

struct SelectedPetDataView: View {
	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }
	
	@ObservedObject var pet: Pet

	@State private var showPetWidgetPreferences = false
	@State private var nameField = ""
	@State private var descField = ""
	@State private var speciesField = ""
	@State private var breedField = ""
	@State private var allergiesField = ""
	@State private var toolbarIsHidden = true


	
	var body: some View {
		List {
			ProfileImageView(pet: pet)
			Button {
				showPetWidgetPreferences.toggle()
			} label: {
				Text("Edit Pet Widget Preferences")
					.foregroundColor(Color("TextColor"))

			}
			.sheet(isPresented: $showPetWidgetPreferences) {
				//TODO: Put a save on dismiss
			} content: {
				PetPreferencesView(selectedPet: pet)
			 }
				
			TextField("Pet name here", text: $nameField)
			.foregroundColor(Color("TextColor"))
			.task {
				nameField = pet.name ?? ""
			}

			TextField("Pet info here", text: $descField)
				.foregroundColor(Color("TextColor"))
				.task {
					descField = pet.desc ?? ""
				}
			WeightSliderView(pet: pet)
			TextField("Pet species", text: $speciesField)
				.foregroundColor(Color("TextColor"))
				.task {
					speciesField = pet.species ?? ""
				}
			TextField("Pet breed", text: $breedField)
				.task {
					breedField = pet.breed ?? ""
				}
			TextField("Pet allergies", text: $allergiesField)
				.foregroundColor(Color("TextColor"))
				.task {
					allergiesField = pet.allergies ?? ""
				}
			if toolbarIsHidden {
				//Sometimes the toolbar was disappearing, added this to always have a save button
				Button("Save Changes") {
					presentationMode.wrappedValue.dismiss()
				}
				.foregroundColor(Color("TextColor"))
			}
			DeleteButton(descriptionOfObjectToDelete: "pet", objectToDelete: pet, dismissCurrentSheet: true)
		}
		.onDisappear(perform: {
			//This should save the changes made even if the window is dismissed, but I included some save buttons as well
			savePetChanges()
		})
		.toolbar{
			ToolbarItem(placement: .automatic) {
					  Button("Save") {
						  presentationMode.wrappedValue.dismiss()
					  }
					  .onAppear {
						  print("Toolbar visable")
						  toolbarIsHidden = false
					  }
			}
		}
		.task {
			dataController.setSelectedPet(to: pet)
		}
	}
	
	func savePetChanges() {
		pet.name = nameField
		pet.desc = descField
		pet.species = speciesField
		pet.breed = breedField
		pet.allergies = allergiesField
		dataController.save()
		presentationMode.wrappedValue.dismiss()
	}
}

struct ProfileImageView: View {
	let pet: Pet
	@State var selectedImage: UIImage = UIImage()
	@State var showPicker: Bool = false
	@EnvironmentObject var dataController: DataController

	
	var body: some View {
		VStack (alignment: .center) {
			Image(uiImage: selectedImage)
				.resizable()
				.frame(maxWidth:200, maxHeight: 200)
				.scaledToFit()
				.task {
					selectedImage = UIImage(data: pet.wrappedProfilePhoto) ?? UIImage()
				}
			Text("Profile Picture")
			Button {
				//dataController.setProfilePhoto(to: selectedImage, for: pet)
				showPicker.toggle()
			} label: {
				Text("Show Image Picker")
			}
		}.sheet(isPresented: $showPicker, onDismiss: {
			dataController.setProfilePhoto(to: selectedImage, for: pet)
		}, content: {
			ImagePickerSwiftUI(
				selectedImage: $selectedImage,
				sourceType:  .photoLibrary // or .camera
			)
		})
	}
}

struct SelectedPetDataView_Previews: PreviewProvider {
    static var previews: some View {
		SelectedPetDataView(pet: Pet())
    }
}
