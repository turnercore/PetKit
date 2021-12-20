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
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
	
	let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
		.makeConnectable()
		.autoconnect()
	
//	var dataController: DataController {
//		DataController(context: viewContext)
//	}
	@EnvironmentObject var dataController: DataController
	
	@State var orientation = UIDevice.current.orientation
	@State var showingData = false
	@State var loading = true
	@State var showAllPetsDataView = false
	@State var petSelectorShowing = true
	//@State var landscape: Bool {
	//	false
	//}
	
	
	var body: some View {
		if loading {
			LoadingView(loading: $loading)
				.task {
					var results = 0
					for _ in pets{
						results += 1
					}
					if results == 0 {
						dataController.populateDefaultDatabase()
					}
					loading.toggle()
				}
		} else {
			GeometryReader { geo in
				//I used geo here instead of the rotated to be more consistant on different devices, I want the bar to be on the vertical when there's more room horizontially and for it to be at the top when it's more squeezed
				if geo.size.width < 700 {
					HomeVertical(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing, pets: pets)
				} else {
					HomeHorizontal(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing, pets: pets)
				}
			}
			.background {
				ZStack {
					Color("AccentColor")
					Image(systemName: "pawprint.fill")
						.resizable()
						.scaledToFit()
						.foregroundColor(Color("PopColor"))
				}
				.ignoresSafeArea()
				//BackgroundView()
			}
			//This makes sure the screen is redrawn when phone is rotated
			.onReceive(orientationChanged) { _ in
				self.orientation = UIDevice.current.orientation
				print(orientation)
			}
		}
	}
}






struct HomeVertical: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Binding var showingData: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	var pets: FetchedResults<Pet>
	@EnvironmentObject var dataController: DataController

	
	var body: some View {
		VStack (alignment: .leading){
			ZStack (alignment: .top) {
				
				PetsRowView(pets: pets)
					.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: Style.shadowColor, width: 2, blur: 5)
					.frame(height: Style.petsBarSize)
			}
			
			SettingsBarView(landscape: .constant(false))
				.padding(.top, -5)
			
			WidgetsView(pets: pets)
				.padding(.top, -20)
				.ignoresSafeArea()
				.zIndex(-1.0)
			
			
		}
	}
}
struct HomeHorizontal: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Binding var showingData: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	var pets: FetchedResults<Pet>
	@EnvironmentObject var dataController: DataController

	
	
	var body: some View {
		HStack {
			PetsColumnView(pets: pets)
				.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: Style.shadowColor, width: 2, blur: 5)
				.frame(width: Style.petsBarSize)
				.ignoresSafeArea()
			
			WidgetsView(pets: pets)
				.ignoresSafeArea()
			//MARK: Testing Add Data Button -
			//					if testing {
			//						Button {
			//							print(dataController.getSelectedPet(in: pets).name ?? "OOOPS NO PET SELECTED?")
			//						} label: {
			//							Text("Print selectedPet")
			//						}
			//
			//						Button {
			//							dataController.addNewPet()
			//						} label: {
			//							HStack {
			//								Image(systemName: "plus.app")
			//								Text("Add New Pet")
			//							}
			//						}
			//
			//						Button("Show all pet data") {
			//							showAllPetsDataView.toggle()
			//						}.sheet(isPresented: $showAllPetsDataView) {
			//							dataController.save()
			//						} content: {
			//							AllPetsDataView()
			//						}
			//
			//					}
			
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	
	static var previews: some View {
		let context = PersistenceController.shared.container.viewContext
		ContentView().environment(\.managedObjectContext, context).previewInterfaceOrientation(.landscapeLeft)
		ContentView().environment(\.managedObjectContext, context).previewInterfaceOrientation(.portrait)
	}
}



