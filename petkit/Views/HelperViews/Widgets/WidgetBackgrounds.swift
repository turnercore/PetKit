//
//  WidgetBackgrounds.swift
//  petkit
//
//  Created by Turner Monroe on 12/23/21.
//

import SwiftUI

struct StandardWidgetSizeBackground: View {
	
	var body: some View {
		RoundedRectangle(cornerRadius: Style.cornerRadius)
			.fill(
				Color("PrimaryColor")
			)
			.frame(width:Style.widgetWidth, height: Style.widgetHeight)
			.shadow(color: Style.shadowColor, radius: Style.shadowRadius, x: Style.shadowOffsetX, y: Style.shadowOffsetY)
	}
}

struct WidgetBackgrounds_Previews: PreviewProvider {
    static var previews: some View {
		StandardWidgetSizeBackground()
    }
}
