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
	//This enables some testing shortcuts and will be deleted when the app is built enough to be able to add and remove data more easily
	var testing = true
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
	let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
		.makeConnectable()
		.autoconnect()
	var dataController: DataController {
		DataController(context: viewContext)
	}
	@State var orientation = UIDevice.current.orientation
	@State var showingData = false
	@State var loaded = false
	@State var showAllPetsDataView = false
	@State var petSelectorShowing = true
	
	
	var body: some View {
		if loaded {
			GeometryReader { geo in
				//I used geo here instead of the rotated to be more consistant on different devices, I want the bar to be on the vertical when there's more room horizontially and for it to be at the top when it's more squeezed
				if geo.size.width < 700 {
					HomeVertical(showingData: $showingData, loaded: $loaded, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing, pets: pets, testing: testing)
				} else {
					HomeHorizontal(showingData: $showingData, loaded: $loaded, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing, pets: pets, testing: testing)
				}
			}//This makes sure the screen is redrawn when phone is rotated
			.onReceive(orientationChanged) { _ in
				self.orientation = UIDevice.current.orientation
			}
		} else {
			LoadingView(loaded: $loaded)
				.task {
					var results = 0
					for _ in pets{
						results += 1
					}
					if results == 0 {
						dataController.populateDefaultDatabase()
					}
					loaded.toggle()
				}
		}
	}
}






struct HomeVertical: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Binding var showingData: Bool
	@Binding var loaded: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	var pets: FetchedResults<Pet>
	private var dataController: DataController {
		DataController(context: viewContext)
	}
	let testing: Bool
	
	
	
	
	var body: some View {
		GeometryReader { geo in
			VStack {
				PetsRowView(pets: pets)
					.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: .primary, width: 2, blur: 5)
					.frame(height: Style.petsBarSize)
				
				WidgetsView(pets: pets)
				
				
				//MARK: Testing Add Data Button -
				if testing {
					Button {
						print(dataController.getSelectedPet(in: pets).name ?? "OOOPS NO PET SELECTED?")
					} label: {
						Text("Print selectedPet")
					}
					
					Button {
						dataController.addNewPet()
					} label: {
						HStack {
							Image(systemName: "plus.app")
							Text("Add New Pet")
						}
					}
					
					Button("Show all pet data") {
						showAllPetsDataView.toggle()
					}.sheet(isPresented: $showAllPetsDataView) {
						dataController.save()
					} content: {
						AllPetsDataView()
					}
					
				}
				
			}
			.background {
				BackgroundView()
			}
		}
	}
}
struct HomeHorizontal: View {
	@Environment(\.managedObjectContext) private var viewContext
	@Binding var showingData: Bool
	@Binding var loaded: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	var pets: FetchedResults<Pet>
	private var dataController: DataController {
		DataController(context: viewContext)
	}
	let testing: Bool
	
	
	
	var body: some View {
		GeometryReader { geo in
			HStack {
				PetsColumnView(pets: pets)
					.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: .primary, width: 2, blur: 5)
					.frame(width: Style.petsBarSize)
					.ignoresSafeArea()
				
				VStack {
					WidgetsView(pets: pets)
					//MARK: Testing Add Data Button -
					if testing {
						Button {
							print(dataController.getSelectedPet(in: pets).name ?? "OOOPS NO PET SELECTED?")
						} label: {
							Text("Print selectedPet")
						}
						
						Button {
							dataController.addNewPet()
						} label: {
							HStack {
								Image(systemName: "plus.app")
								Text("Add New Pet")
							}
						}
						
						Button("Show all pet data") {
							showAllPetsDataView.toggle()
						}.sheet(isPresented: $showAllPetsDataView) {
							dataController.save()
						} content: {
							AllPetsDataView()
						}
						
					}
				}
				
				
			}
			
			.background {
				BackgroundView()
			}
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


