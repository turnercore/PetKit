//
//  ActivityWidget.swift
//  petkit
//
//  Created by Turner Monroe on 12/10/21.
//

import SwiftUI

struct ActivityWidget: View {
	@ObservedObject var pet: Pet
    var body: some View {
		ZStack {
			Rectangle()
				.foregroundColor(Color("SecondaryColor"))
				.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: Style.shadowOffsetX, y: Style.shadowOffsetY)
			
			Text("Activity Widget")
				.foregroundColor(Color("TextColor"))
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
    }
}

struct ActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
		ActivityWidget(pet: Pet())
    }
}
