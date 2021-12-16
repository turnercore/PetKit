//
//  DeleteButton.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI

struct DeleteButton: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode
	let descriptionOfObjectToDelete: String
	var objectToDelete: AnyObject
	private var dataController: DataController {
		DataController(context: viewContext)
	}
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
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
