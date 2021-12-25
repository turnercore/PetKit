//
//  ActivityWidget.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct ActivityWidget: View {
	@EnvironmentObject var dataController: DataController
	
	var body: some View {
		ZStack {
			StandardWidgetSizeBackground()
			Text("Activity Widget")
				.foregroundColor(Color("TextColor"))
				.bold()
		}
    }
}

struct ActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
		ActivityWidget()
    }
}
