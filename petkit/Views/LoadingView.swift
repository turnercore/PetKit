//
//  LoadingView.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI

///Loading page that can come up whenever the app is loading data, currently the animation isn't working for some reason
struct LoadingView: View {
	@Binding var loading: Bool
	let pawCount = 3
	@State var currentIndex = -1
	@State var currentOffset = CGSize.zero
	
	struct Paw: View {
		let isCurrent: Bool
		var body: some View {
			Image(systemName: "pawprint.circle.fill")
				.frame(width: 25, height: 35)
				.offset(
					isCurrent
					? .init(width: -16, height: -25 )
					: .init(width: -16, height: 15)
				)
				.scaleEffect(isCurrent ? 3.5 : 0.4)
				.padding(.all, -10)
				.foregroundColor(isCurrent ? Color("PopColor2") : Color("PrimaryColor"))
				.animation(Style.springAnimation, value: isCurrent)
		}
	}
	
	var body: some View {
		ZStack {
			BackgroundView()
			HStack {
				Text("Loading")
					.font(.title)
					.foregroundColor(Color("PrimaryColor"))
				Group {
					ForEach(0..<pawCount) { index in
						Paw(
							isCurrent: (index == currentIndex)
						)
					}
				}
				.offset(currentOffset)
				.onAppear(perform: animate)
			}
		}
		//.animation(.easeOut, value: loading)

	}
	
	func animate() {
		var iteration = 0
			Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
				currentIndex = (currentIndex + 1) % pawCount
				
				iteration += 1
//				if !loading {
//					timer.invalidate()
//				}
			}
		}
	}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
		LoadingView(loading: .constant(true))
    }
}
