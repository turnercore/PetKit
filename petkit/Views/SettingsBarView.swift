//
//  SettingsBarView.swift
//  petkit
//
//  Created by Turner Monroe on 12/16/21.
//

import SwiftUI

struct SettingsBarView: View {
	@Binding var petsRowCollapsed: Bool
	var body: some View {
			HStack {
				PetSelectorShowOrHide(petsRowCollapsed: $petsRowCollapsed)
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
			.frame(height: 75)
			.cornerRadius(Style.cornerRadius)
			.shadow(color: Style.shadowColor.opacity(0.35), radius: Style.shadowfaintRadius, x: 0, y: 20)
	}
}

struct PetSelectorShowOrHide: View {
	@EnvironmentObject var dataController: DataController
	@Binding var petsRowCollapsed: Bool
	var body: some View {
		HStack {
			Button {
				print("Hide/Show Pet Selector")
				withAnimation {
					petsRowCollapsed.toggle()
				}
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
	@EnvironmentObject var dataController: DataController
	@State var editPetDataShowing = false

	var body: some View {
		ZStack {
			Button {
				print("Pet settings button pushed")
				editPetDataShowing.toggle()
			} label: {
				Image(systemName: "gearshape.fill")
					.resizable()
					.padding(.all, 8)
					.scaledToFit()
			}
			.sheet(isPresented: $editPetDataShowing) {
				print("sheet dismissed")
			} content: {
				SelectedPetDataView(pet: dataController.selectedPet)
			}

		}
	}
}

struct AddNewPetButton: View {
	@EnvironmentObject var dataController: DataController

	var body: some View {
		ZStack {
			Button {
				print("Add new pet button pushed")
				dataController.addNewPet()
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

//struct SettingsBarView_Previews: PreviewProvider {
//	static var previews: some View {
//		SettingsBarView(orientation: )
//	}
//}
