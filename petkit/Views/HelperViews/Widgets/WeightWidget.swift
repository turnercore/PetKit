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
			Rectangle()
				.fill(
					LinearGradient(gradient: Style.widgetGradient, startPoint: Style.widgetGradientStartPoint, endPoint: Style.widgetGradientEndPoint)
				)
				.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: Style.shadowOffsetX, y: Style.shadowOffsetY)

			VStack (alignment: .center) {
				Text("Weight Widget")
					.bold()
				Text("Current Weight for \(dataController.selectedPet.wrappedName): \(dataController.selectedPet.currentWeight)").bold()
			}
			.foregroundColor(Color("TextColor"))
			

			
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
	}
}
