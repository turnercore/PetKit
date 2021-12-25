//
//  DeleteButton.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI
import CoreData

struct DeleteButton: View {

	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var dataController: DataController

	
	///This changes the name of the button
	let descriptionOfObjectToDelete: String
	
	///Pass in any Core Data Class and it will be deleted appropriately
	var objectToDelete: NSManagedObject
	private var pets: [Pet] { dataController.pets }
	
	///setting to determine if the button should dismiss the sheet after deleting the object
	var dismissCurrentSheet: Bool = false
	
    var body: some View {
		Button("Delete " + descriptionOfObjectToDelete.capitalized){
			if objectToDelete .isKind(of: Pet.self) {
				dataController.deletePet(objectToDelete as! Pet)
				//dataController.viewContext.delete(objectToDelete)
				//dataController.selectedPet = dataController.pets[0]
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
