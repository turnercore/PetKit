//
//  HomeWidgetView.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct WidgetsView: View {
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }

	
    var body: some View {
		ScrollView (.vertical) {
			withAnimation {
				WidgetListView()
			}
		}
		.padding()
	}
}

struct WidgetListView: View {
	@State private var showEditPetAllData = false
	@EnvironmentObject var dataController: DataController
	private var petPreferences: Preferences {
		dataController.selectedPet.preferences ?? Preferences()
	}


	
	var body: some View {
			LazyVGrid(
				columns:[GridItem.init(.adaptive(minimum: 250, maximum: .infinity))],
				spacing: Style.gridSpacing) {
					if petPreferences.showSizeWidget == true {
						SizeWidget()
					}
//
//					if petPreferences.showWeightWidget == true {
//						WeightWidget()
//					}
//
//					if petPreferences.showActivityWidget == true {
//						ActivityWidget()
//					}
//
					EditPetDataButton(pet: dataController.selectedPet, showingData: $showEditPetAllData)
						.padding(.bottom, 50)
			}
		}
	}



