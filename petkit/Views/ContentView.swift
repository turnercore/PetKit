//
//  ContentView.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//


import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
	@State private var showEditPetAllData = false
	let loadingScreenTest = false
	@Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?
	@EnvironmentObject var dataController: DataController
	@State var showingData = false
	@State var loading = true
	@State var showAllPetsDataView = false
	@State var petSelectorShowing = true
	
	
	
	var body: some View {
		if loading {
			LoadingView(loading: $loading)
				.task {
					DispatchQueue.global().async {
						if loadingScreenTest {sleep(5)}
						dataController.loadAppStartup {
							loading.toggle()
						}
					}
				} //puts up the loading screen and runs any app startup code needed
		} else {
			ZStack {
				Color("AccentColor")
					.ignoresSafeArea()
				Image(systemName: "pawprint.fill")
					.resizable()
					.scaledToFit()
					.foregroundColor(Color("PopColor"))
				
				if horizontalSize == .regular {
					HStack (alignment: .top){
						HomeView(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing)
					}
				} else if horizontalSize == .compact {
					VStack (alignment: .leading) {
						HomeView(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing)
					}
				} else {
					Text("Something has gone horribly wrong.")
				}
			}
		}
	}
}

struct HomeView: View {
	@Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?
	@Binding var showingData: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	@EnvironmentObject var dataController: DataController
	@State var petsRowCollapsed: Bool = false

	
	
	var body: some View {
		if !petsRowCollapsed {
			PetsRowView()
			.ignoresSafeArea(.all, edges: horizontalSize == .regular ? [.vertical,.horizontal] : [.horizontal])
			.padding(.top, horizontalSize == .regular ? 5 : 20)
			.transition(AnyTransition.move(edge: horizontalSize == .regular ? .leading : .top))
		}
		ZStack {
			SettingsBarView(petsRowCollapsed: $petsRowCollapsed)
			WidgetsView()
				.zIndex(-1.0)
				.ignoresSafeArea()
		}
	}
}



//struct ContentView_Previews: PreviewProvider {
//
//	static var previews: some View {
//		let context = PersistenceController.shared.container.viewContext
//		ContentView().environment(\.managedObjectContext, context).previewInterfaceOrientation(.landscapeLeft)
//
//		ContentView().environment(\.managedObjectContext, context).previewInterfaceOrientation(.portrait)
//	}
//}
