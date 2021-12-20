/*
  petkitApp.swift
  petkit

  Created by Turner Monroe on 12/7/21.
*/

import SwiftUI
import CoreData


@main
struct petkitApp: App {
	let persistenceController = PersistenceController.shared
	@FetchRequest(entity: Pet.entity(), sortDescriptors: []) var pets: FetchedResults<Pet>
	var dataController: DataController {
		DataController(context: persistenceController.container.viewContext, pets: pets)
	}
	
    var body: some Scene {
		WindowGroup {
			ContentView()
			.environment(\.managedObjectContext, persistenceController.container.viewContext)
			.environmentObject(dataController)
		}
	}
}


