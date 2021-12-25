//
//  WeightHomeView.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct WeightWidget: View {
	@EnvironmentObject var dataController: DataController

	var body: some View {
		ZStack {
			StandardWidgetSizeBackground()

			VStack (alignment: .center) {
				Text("Weight Widget")
					.bold()
				Text("Current Weight for \(dataController.selectedPet.wrappedName): \(dataController.selectedPet.currentWeight)").bold()
			}
			.foregroundColor(Color("TextColor"))
		}
	}
}
