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
	// @Environment(\.managedObjectContext) private var viewContext
	let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
		.makeConnectable()
		.autoconnect()
	@EnvironmentObject var dataController: DataController
	private var pets: [Pet] { dataController.pets }
	
	@State var orientation = UIDevice.current.orientation
	@State var showingData = false
	@State var loading = true
	@State var showAllPetsDataView = false
	@State var petSelectorShowing = true

	
	
	var body: some View {
		if loading {
			LoadingView(loading: $loading)
				.environmentObject(dataController)
				.task {
					if pets == [] {
						dataController.populateDefaultDatabase()
					}
					sleep(2)
					loading.toggle()
				}
		} else {
			GeometryReader { geo in
				//I used geo here instead of the rotated to be more consistant on different devices, I want the bar to be on the vertical when there's more room horizontially and for it to be at the top when it's more squeezed
				if geo.size.width < 700 {
					HomeVertical(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing)
							.environmentObject(dataController)

				} else {
					HomeHorizontal(showingData: $showingData, showAllPetsDataView: $showAllPetsDataView, petSelectorShowing: $petSelectorShowing)
							.environmentObject(dataController)
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
	// @Environment(\.managedObjectContext) private var viewContext
	@Binding var showingData: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	@EnvironmentObject var dataController: DataController

	
	var body: some View {
		VStack (alignment: .leading){
			ZStack (alignment: .top) {
				
				PetsRowView()
					.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: Style.shadowColor, width: 2, blur: 5)
					.frame(height: Style.petsBarSize)
					.environmentObject(dataController)

			}
			
			SettingsBarView(landscape: .constant(false))
				.padding(.top, -5)
				.environmentObject(dataController)

			
			WidgetsView()
				.padding(.top, -20)
				.ignoresSafeArea()
				.zIndex(-1.0)
				.environmentObject(dataController)

			
			
		}
	}
}
struct HomeHorizontal: View {
	@Binding var showingData: Bool
	@Binding var showAllPetsDataView: Bool
	@Binding var petSelectorShowing: Bool
	@EnvironmentObject var dataController: DataController

	
	
	var body: some View {
		HStack {
			PetsColumnView()
				.environmentObject(dataController)
				.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: Style.shadowColor, width: 2, blur: 5)
				.frame(width: Style.petsBarSize)
				.ignoresSafeArea()
			
			
			WidgetsView()
				.environmentObject(dataController)
				.ignoresSafeArea()
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



