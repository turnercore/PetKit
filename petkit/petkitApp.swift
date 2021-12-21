/*
  petkitApp.swift
  petkit

  Created by Turner Monroe on 12/7/21.
*/

import SwiftUI
import CoreData


@main
struct petkitApp: App {

	let dataController = DataController.shared
	
    var body: some Scene {
		WindowGroup {
			ContentView()
			.environmentObject(dataController)
		}
	}
}


