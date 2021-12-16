//
//  BackgroundView.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI


struct BackgroundView: View {
	var body: some View {
		ZStack {
			Image("BackgroundPaws")
				.resizable(resizingMode: .tile)
				.opacity(0.15)
			Color("PrimaryColor").blendMode(.colorDodge)
		}
		.ignoresSafeArea()
	}
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
