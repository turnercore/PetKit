//
//  TestData.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

struct WeightSliderView: View {
	@ObservedObject var pet: Pet
	@State private var progress: Double = 0
	@State private var stringWeight: String = "0"
	
	var body: some View {
		VStack {
			Slider(value: Binding(
				get: {
					self.progress
				}, set: { (newVal) in
					let roundedNewVal = round(newVal * 100) / 100
					self.progress = roundedNewVal
					stringWeight = String(progress)
				}), in: 0...Constants.maxPetWeight,
				   step: 0.01,
				   label: {
				Text("Current Weight")
			}, onEditingChanged: { editing in
				pet.currentWeight.value = progress
				print(pet.currentWeight.value)
			})
				.task {
					progress = pet.currentWeight.value
					stringWeight = String(progress)
				}
				.onDisappear(perform: {
					let roundedProgress = round(progress * 100) / 100.0
					pet.currentWeight.value = roundedProgress
				})
				.padding(.all)
			HStack {
				TextField("Enter Current Weight", text: $stringWeight)
				Button {
					self.updateWeight()
				} label: {
					Text("Save")
				}
			}
		}
	}
	
	func updateWeight() {
		progress = Double(stringWeight) ?? 0
	}
}

