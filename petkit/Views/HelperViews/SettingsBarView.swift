//
//  SettingsBarView.swift
//  petkit
//
//  Created by Turner Monroe on 12/16/21.
//

import SwiftUI

struct SettingsBarView: View {
	@Binding var landscape: Bool
	var body: some View {
		Group {
		if landscape {
			VStack {
				Text("Landscape/wide mode")
			}
		} else {
			HStack {
				PetSelectorShowOrHide()
					.shadow(radius: Style.shadowPopRadius)
				PetSettingsButton()
					.shadow(radius: Style.shadowPopRadius)
				AddNewPetButton()
					.shadow(radius: Style.shadowPopRadius)
				ShareButton()
					.shadow(radius: Style.shadowPopRadius)
			}
			.foregroundColor(Color("PopColor2"))
			.background(Color("AccentColor"))
		}
		}
		//.zIndex(25)
		.frame(width: .infinity, height: 75)
		.cornerRadius(Style.cornerRadius)
		.shadow(color: Style.shadowColor.opacity(0.35), radius: Style.shadowfaintRadius, x: 0, y: 20)
	}
}

struct PetSelectorShowOrHide: View {
	var body: some View {
		HStack {
			Button {
				print("Hide/Show Pet Selector")
			} label: {
				Image(systemName: "chevron.up.square.fill")
					.resizable()
					.padding(.all, 8)
					.scaledToFit()
			}
		}
	}
}

struct PetSettingsButton: View {
	var body: some View {
		ZStack {
			Button {
				print("Pet settings button pushed")
			} label: {
				Image(systemName: "gearshape.fill")
					.resizable()
					.padding(.all, 8)
					.scaledToFit()
				
			}
		}
	}
}

struct AddNewPetButton: View {
	var body: some View {
		ZStack {
			Button {
				print("Add new pet button pushed")
			} label: {
				Image(systemName: "plus.square.fill")
					.resizable()
					.padding(.all, 8)
					.scaledToFit()
				
			}
		}
	}
}

struct ShareButton: View {
	var body: some View {
		ZStack {
			Button {
				print("Share Button Pushed")
			} label: {
				Image(systemName: "square.and.arrow.up.fill")
					.resizable()
					.padding(.all, 10)
					.scaledToFit()
					.offset(x:0, y: -5)
				
			}
		}
	}
}



struct SettingsBarView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsBarView(landscape: .constant(false))
	}
}
