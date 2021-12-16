//
//  LoadingView.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI

struct LoadingView: View {
	
	let pawCount = 3
	@State var currentIndex = -1
	@Binding var loading: Bool
	@State var currentOffset = CGSize.zero
	
	struct Paw: View {
		let isCurrent: Bool
		var body: some View {
			Image(systemName: "pawprint.circle.fill")
				.frame(width: 25, height: 35)
				.offset(
					isCurrent
					? .init(width: -16, height: -35 )
					: .init(width: -16, height: 15)
				)
				.scaleEffect(isCurrent ? 3.5 : 0.4)
				.padding(.all, -10)
				.foregroundColor(isCurrent ? Color("PopColor") : Color("PrimaryColor"))
				.animation(.spring(), value: isCurrent)
		}
	}
	
	var body: some View {
		ZStack {
			BackgroundView()
			HStack {
				Text("Loading")
					.font(.title)
					.foregroundColor(Color("TextColor"))
				Group {
					ForEach(0..<pawCount) { index in
						Paw(
							isCurrent: (index == currentIndex)
						)
					}
				}
				.offset(currentOffset)
				.gesture(
					DragGesture()
						.onChanged { gesture in
							currentOffset = gesture.translation
						}
						.onEnded { gesture in
							currentOffset = .zero
						}
				)
				.onAppear(perform: animate)
			}
		}
	}
	
	func animate() {
		var iteration = 0
			Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
				currentIndex = (currentIndex + 1) % pawCount
				
				iteration += 1
				if !loading {
					timer.invalidate()
				}
			}
		}
	}



struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
		LoadingView(loading: .constant(true))
    }
}
