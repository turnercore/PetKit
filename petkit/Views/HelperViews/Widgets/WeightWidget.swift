//
//  WeightHomeView.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct WeightWidget: View {
	@ObservedObject var pet: Pet
	
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
				Text("Current Weight for \(pet.wrappedName): \(pet.currentWeight.value)").bold()
			}
			.foregroundColor(Color("TextColor"))
			

			
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
	}
}
