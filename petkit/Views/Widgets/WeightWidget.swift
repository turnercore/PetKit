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
				.foregroundColor(Color.secondary)
				.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: 5, y: 5)
			
			VStack (alignment: .center) {
				Text("Weight Widget")
				Text("Current Weight for \(pet.wrappedName): \(pet.currentWeight.value)")
			}
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
	}
}
