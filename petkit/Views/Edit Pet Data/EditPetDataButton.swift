//
//  EditPetDataButton.swift
//  petkit
//
//  Created by Turner Monroe on 12/14/21.
//

import SwiftUI
import CoreData


struct EditPetDataButton: View {
	@ObservedObject var pet: Pet
	@Binding var showingData: Bool
	@Environment(\.managedObjectContext) private var viewContext
	let dataController = DataController()
	
	var body: some View {
		Button {
			showingData.toggle()
		} label: {
			Text("Show Data")
		}
		.sheet(isPresented: $showingData) {
			//when dismissed try to save the data
			try? viewContext.save()
		} content: {
			SelectedPetDataView(pet: pet)
		}
	}
}

struct EditPetDataButton_Previews: PreviewProvider {
    static var previews: some View {
		EditPetDataButton(pet: Pet(), showingData: .constant(true))
    }
}
