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
				.foregroundColor(Color.secondary)
				.shadow(color: .gray, radius: Style.shadowRadius, x: 5, y: 5)

			Text("Activity Widget")
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
    }
}

struct ActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
		ActivityWidget(pet: Pet())
    }
}
