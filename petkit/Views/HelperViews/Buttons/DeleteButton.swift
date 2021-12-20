//
//  DeleteButton.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI
import CoreData

struct DeleteButton: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var dataController: DataController

	
	///This changes the name of the button
	let descriptionOfObjectToDelete: String
	
	///Pass in any Core Data Class and it will be deleted appropriately
	var objectToDelete: NSManagedObject
	
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
	
	//setting to determine if the button should dismiss the sheet after deleting the object
	var dismissCurrentSheet: Bool = false
	
    var body: some View {
		Button("Delete " + descriptionOfObjectToDelete.capitalized){
			print("Delete Button pushed")
			if objectToDelete .isKind(of: Pet.self) {
				print("Pet to be deleted")
				dataController.deletePet(pet: objectToDelete as! Pet, allPets: pets)
			}
			if dismissCurrentSheet {
				presentationMode.wrappedValue.dismiss()
			}
		
		}
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(descriptionOfObjectToDelete: "pet", objectToDelete: Pet())
    }
}
