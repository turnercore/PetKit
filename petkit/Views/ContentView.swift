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
	var testing = true
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: Pet.entity(),
				  sortDescriptors: []) var pets: FetchedResults<Pet>
	private var dataController = DataController()
	@State var showingData = false
	@State var loaded = false
	@State var showAllPetsDataView = false
    

    var body: some View {
		withAnimation {
				GeometryReader { geo in
					if loaded {
					VStack {
						PetsRowView(pets: pets)
							.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: .primary, width: 2, blur: 5)
							.frame(height: geo.size.height * 0.2)
						
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
						ZStack {
							Image("BackgroundPaws")
								.resizable(resizingMode: .tile)
								.opacity(0.15)
							Color.accentColor.blendMode(.colorDodge)
						}
						.ignoresSafeArea()
					}
				}else {
					Text("Loading...")
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
	}
}




struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
		let context = PersistenceController.shared.container.viewContext
		return ContentView().environment(\.managedObjectContext, context)
    }
}


