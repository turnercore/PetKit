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
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: Pet.entity(),
				  sortDescriptors: []) var pets: FetchedResults<Pet>
	
	@ObservedObject var pet: Pet
	private var dataController: DataController {
		DataController(context: viewContext)
	}
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
			}
			.sheet(isPresented: $showPetWidgetPreferences) {
				//TODO: Put a save on dismiss
			} content: {
				PetPreferencesView(selectedPet: pet)
			 }
				
			TextField("Pet name here", text: $nameField)
			.task {
				nameField = pet.name ?? ""
			}

			TextField("Pet info here", text: $descField)
				.task {
					descField = pet.desc ?? ""
				}
			WeightSliderView(pet: pet)
			TextField("Pet species", text: $speciesField)
				.task {
					speciesField = pet.species ?? ""
				}
			TextField("Pet breed", text: $breedField)
				.task {
					breedField = pet.breed ?? ""
				}
			TextField("Pet allergies", text: $allergiesField)
				.task {
					allergiesField = pet.allergies ?? ""
				}
			if toolbarIsHidden {
				//Sometimes the toolbar was disappearing, added this to always have a save button
				Button("Save Changes") {
					savePetChanges()
				}
			}
			DeleteButton(descriptionOfObjectToDelete: "pet", objectToDelete: pet)
		}
		.onDisappear(perform: {
			//This should save the changes made even if the window is dismissed, but I included some save buttons as well
			savePetChanges()
		})
		.toolbar{
			ToolbarItem(placement: .automatic) {
					  Button("Save") {
						  savePetChanges()
					  }
					  .onAppear {
						  print("Toolbar visable")
						  toolbarIsHidden = false
					  }
			}
		}
		.task {
			dataController.changeSelectedPetTo(pet: pet, in: pets)
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
	@Environment(\.managedObjectContext) private var viewContext
	@ObservedObject var pet: Pet
	@State var selectedImage: UIImage = UIImage()
	@State var showPicker: Bool = false
	private var dataController: DataController {
		DataController(context: viewContext)
	}
	
	var body: some View {
		VStack (alignment: .center) {
			Image(uiImage: selectedImage)
				.resizable()
				.frame(maxWidth:200, maxHeight: 200)
				.scaledToFit()
				.task {
					selectedImage = UIImage(data: pet.profilePhoto.wrappedPhoto) ?? UIImage()
				}
			Text("Profile Picture")
			Button {
				dataController.setProfilePicture(picture: selectedImage, for: pet)
				showPicker.toggle()
			} label: {
				Text("Show Image Picker")
			}
		}.sheet(isPresented: $showPicker, onDismiss: {
			dataController.setProfilePicture(picture: selectedImage, for: pet)
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
