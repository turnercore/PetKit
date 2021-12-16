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
	private var dataController: DataController {
		DataController(context: viewContext)
	}
	
	var body: some View {
		Button {
			showingData.toggle()
		} label: {
			ZStack(alignment: .center) {
				Rectangle()
					.foregroundColor(Color("AccentColor"))
					.cornerRadius(Style.cornerRadius)
				Text("Show Data")
					.font(.subheadline)
					.foregroundColor(Color("TextColor"))
			}
			.frame(width: Style.widgetWidth / 1.25, height: Style.widgetHeight / 3)
			.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: Style.shadowOffsetX, y: Style.shadowOffsetY)
		}
		.sheet(isPresented: $showingData) {
			print("SelectedPetDataView dismissed")
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
