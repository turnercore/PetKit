//
//  HomeWidgetView.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct WidgetsView: View {
	let pets: FetchedResults<Pet>
	private let dataController = DataController()
	
    var body: some View {
		ScrollView (.vertical) {
			withAnimation {
				WidgetListView(pet: dataController.getSelectedPet(in: pets))
			}
		}
		.padding()
	}
}

struct WidgetListView: View {
	@ObservedObject var pet: Pet
	@State private var showEditPetAllData = false

	
	var body: some View {
		LazyVGrid(
			columns:[GridItem.init(.adaptive(minimum: 250, maximum: .infinity))],
			spacing: Style.gridSpacing) {
				if pet.widgets?.showSizeWidget == true {
					SizeWidget(pet: pet)
				}
				
				if pet.widgets?.showWeightWidget == true {
					WeightWidget(pet: pet)
				}
				
				if pet.widgets?.showActivityWidget == true {
					ActivityWidget(pet: pet)
				}
				
				EditPetDataButton(pet: pet, showingData: $showEditPetAllData)
			}
	}
}


//
//struct HomeWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//		HomeWidgetView(pets: Pet())
//    }
//}


