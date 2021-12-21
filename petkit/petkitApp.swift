/*
  petkitApp.swift
  petkit

  Created by Turner Monroe on 12/7/21.
*/

import SwiftUI
import CoreData


@main
struct petkitApp: App {

	  var dataController: DataController

	  init() {
		let manager = PersistenceController()
		let managedObjectContext = manager.container.viewContext
		dataController = DataController(context: managedObjectContext)
	  }
	
    var body: some Scene {
		WindowGroup {
			ContentView()
			.environmentObject(dataController)
		}
	}
}


