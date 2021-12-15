//
//  UserPreferencesView.swift
//  petkit
//
//  Created by Turner Monroe on 12/13/21.
//

import SwiftUI

struct PetPreferencesView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode
	@ObservedObject var selectedPet: Pet
	
	//Preferences as a State variable
	@State private var weightWidgetToggle: Bool = true
	@State private var sizeWidgetToggle: Bool = true
	@State private var activityWidgetToggle: Bool = true


	
    var body: some View {
		List{
			Toggle(isOn: $weightWidgetToggle) {
				Text("Show Weight Widget")
			}.task {
				weightWidgetToggle = selectedPet.widgets?.showWeightWidget ?? true
			}
			
			Toggle(isOn: $sizeWidgetToggle) {
				Text("Show Size Widget")
			}.task {
				sizeWidgetToggle = selectedPet.widgets?.showSizeWidget ?? true
			}
			
			Toggle(isOn: $activityWidgetToggle) {
				Text("Show Activity Widget")
			}.task {
				activityWidgetToggle = selectedPet.widgets?.showActivityWidget ?? true
			}
			
			Button("Save") {
				selectedPet.widgets?.showWeightWidget = weightWidgetToggle
				selectedPet.widgets?.showSizeWidget = sizeWidgetToggle
				selectedPet.widgets?.showActivityWidget = activityWidgetToggle
				presentationMode.wrappedValue.dismiss()
			}
		}
    }
}

struct PetPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		PetPreferencesView(selectedPet: Pet())
    }
}
