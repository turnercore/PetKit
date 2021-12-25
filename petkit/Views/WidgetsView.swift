//
//  HomeWidgetView.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct WidgetsView: View {
	@EnvironmentObject var dataController: DataController
	@Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?

	private var pets: [Pet] { dataController.pets }

	
    var body: some View {
		ScrollView (.vertical) {
			withAnimation {
				WidgetListView()
					.ignoresSafeArea()
			}
		}
		.padding()
	}
}

struct WidgetListView: View {
	@EnvironmentObject var dataController: DataController
	@Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?


	
	var body: some View {
			LazyVGrid(
				columns:[GridItem.init(.adaptive(minimum: Style.widgetWidth, maximum: .infinity))],
				spacing: Style.gridSpacing) {
					if dataController.selectedPet.preferences?.showSizeWidget ?? true {
						SizeWidget()
					}

					if dataController.selectedPet.preferences?.showWeightWidget ?? true {
						WeightWidget()
					}

					if dataController.selectedPet.preferences?.showActivityWidget ?? true {
						ActivityWidget()
					}
			}
				.padding(.top, horizontalSize == .regular ? 25 : 10)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	}



