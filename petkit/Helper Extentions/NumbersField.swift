//
//  NumbersField.swift
//  petkit
//
//  Created by Turner Monroe on 12/12/21.
//

//import SwiftUI
//import Combine
//
//struct NumbersField: View {
//	let descriptionText: String
//	@Binding var number: String
//
//	var body: some View {
//		TextField(descriptionText, text: number)
//			.keyboardType(.numberPad)
//			.onReceive(Just(number)) { newValue in
//				let filtered = newValue.filter { "0123456789".contains($0) }
//				if filtered != newValue {
//					self.number = filtered
//				}
//		}
//	}
//}
