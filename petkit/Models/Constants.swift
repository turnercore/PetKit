//
//  Constants.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//

import CoreGraphics
import SwiftUI

enum Style {
	//Text
	static let kerning: CGFloat = 1.15
	
	//Overall App Look
	static let cornerRadius: Double = 12.0
	
	
	
	//Widgets
	static let widgetWidth: Double = 250.0
	static let widgetHeight: Double = 250.0
	static let gridSpacing: Double = 20.0
	
	
	//Shadows
	static let shadowRadius: Double = 5.0
	static let shadowColor: Color = .black
	static let shadowOffsetX: Double = 5.0
	static let shadowOffsetY: Double = 5.0
	
	//Pet Selector Bar
	static let petsBarHeightMultiplier = 0.15
	static let petsBarSize: CGFloat? = 125
}

enum Constants {
	static let maxPetWeight: Double = 100.0
}
