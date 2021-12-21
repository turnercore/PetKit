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
			Rectangle()
				.fill(
					LinearGradient(gradient: Style.widgetGradient, startPoint: Style.widgetGradientStartPoint, endPoint: Style.widgetGradientEndPoint)
				)
				.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: Style.shadowOffsetX, y: Style.shadowOffsetY)
			
			Text("Size Widget")
				.foregroundColor(Color("TextColor"))
				.bold()
		}
		.frame(width:Style.widgetWidth, height: Style.widgetHeight)
    }
}
