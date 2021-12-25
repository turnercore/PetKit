//
//  SizeWidget.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct SizeWidget: View {
	@EnvironmentObject var dataController: DataController

	var body: some View {
		ZStack {
			StandardWidgetSizeBackground()
			
			Text("Size Widget")
				.foregroundColor(Color("TextColor"))
				.bold()
		}
    }
}


