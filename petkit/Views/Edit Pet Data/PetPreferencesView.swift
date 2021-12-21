//
//  UserPreferencesView.swift
//  petkit
//
//  Created by Turner Monroe on 12/13/21.
//

import SwiftUI

struct PetPreferencesView: View {
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
					.foregroundColor(Color("TextColor"))

			}.task {
				weightWidgetToggle = selectedPet.preferences?.showWeightWidget ?? true
			}
			
			Toggle(isOn: $sizeWidgetToggle) {
				Text("Show Size Widget")
					.foregroundColor(Color("TextColor"))

			}.task {
				sizeWidgetToggle = selectedPet.preferences?.showSizeWidget ?? true
			}
			
			Toggle(isOn: $activityWidgetToggle) {
				Text("Show Activity Widget")
					.foregroundColor(Color("TextColor"))

			}.task {
				activityWidgetToggle = selectedPet.preferences?.showActivityWidget ?? true
			}
			
			Button("Save") {
				selectedPet.preferences?.showWeightWidget = weightWidgetToggle
				selectedPet.preferences?.showSizeWidget = sizeWidgetToggle
				selectedPet.preferences?.showActivityWidget = activityWidgetToggle
				presentationMode.wrappedValue.dismiss()
			}
			.foregroundColor(Color("TextColor"))

			
		}
    }
}

struct PetPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
		PetPreferencesView(selectedPet: Pet())
    }
}
