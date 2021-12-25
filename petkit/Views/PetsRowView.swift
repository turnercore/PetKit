//
//  PetsRowView.swift
//  petkit
//
//  Created by Turner Monroe on 12/7/21.
//

import SwiftUI
import CoreData
import UIKit


struct PetsRowView: View {
	@Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?
	@EnvironmentObject var dataController: DataController
	@State var showSettingsMenu: Bool = false
	
	var body: some View {
		ZStack {
			Color("PrimaryColor")
			ScrollView (horizontalSize == .regular ? .vertical : .horizontal) {
				
				if horizontalSize == .regular {
					LazyVStack {
						Rectangle()
							.frame(width: 1, height: 100)
							.foregroundColor(Color.clear)
						
						ForEach(dataController.pets) {pet in
							PetProfileButton(pet: pet)
						}
					}
				} else {
					LazyHStack {
						//						Rectangle()
						//							.frame(width: 100, height: 1)
						//	.foregroundColor(Color.clear)
						
						ForEach(dataController.pets) {pet in
							PetProfileButton(pet: pet)
						}
					}
					
				}
			}
		}
		.innerShadow(using: Rectangle(), angle: Angle(degrees: 0.00), color: Style.shadowColor, width: 2, blur: 5)
		.frame(maxWidth: horizontalSize == .regular ? Style.petsBarSize : .infinity, maxHeight: horizontalSize == .regular ? .infinity : Style.petsBarSize)
	}
}

struct PetProfileButton: View {
	let pet: Pet
	@EnvironmentObject var dataController: DataController
	@State private var deletePetConfirmationShowing: Bool = false
	@GestureState var isDetectingDragging = false
	@State private var completedLongPress = false
	@State private var location: CGPoint = CGPoint(x: 60, y: 60)
	@State private var showingTrashcan = false
	
	var dragGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				self.location.y = value.location.y
				print(self.location.y)
				if self.location.y > 100 {
					withAnimation {
						showingTrashcan = true
						print(showingTrashcan)
					}
				}
			}
			.onEnded { _ in
				if showingTrashcan {
					deletePetConfirmationShowing.toggle()
				} else {
					self.location = CGPoint(x: 60, y: 60)
					showingTrashcan = false
				}
			}
		//			.onEnded { finished in
		//				print("Dragging finished")
		//				self.completedLongPress.toggle()
		//				self.deletePetConfirmationShowing.toggle()
		//			}
	}
	
	var actionSheet: ActionSheet {
		ActionSheet(title: Text("Action"),
					message: Text("Description"),
					buttons: [
						.default(Text("OK"), action: {
							withAnimation {
								self.location = CGPoint(x: 60, y: 60)
								showingTrashcan.toggle()
							}
							
						}),
						.destructive(Text("Delete"), action: {
							showingTrashcan.toggle()
							dataController.deletePet(pet)
							dataController.save()
							print("Delete Pet")
						})
					]
		)
	}
	
	var body: some View {
		VStack (alignment: .center) {
			if showingTrashcan {
				Image(systemName: "trash.fill")
					.resizable()
					.foregroundColor(.red)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.scaledToFill()
					.transition(AnyTransition.opacity)
					.onTapGesture {
						withAnimation {
							showingTrashcan.toggle()
						}
					}
			}
			
			Button {
				dataController.setSelectedPet(to: pet)
			} label: {
				VStack {
					Image(uiImage: UIImage(data: pet.wrappedProfilePhoto) ?? UIImage(systemName: "photo")!)
						.resizable()
						.frame(width: pet.selected ? 100 : 80, height: pet.selected ? 100 : 80)
						.scaledToFit()
						.clipShape(Circle())
						.shadow(color: pet.selected
								? Color("PopColor")
								: Color(.clear),
								radius: Style.shadowRadius,
								x: Style.shadowOffsetX,
								y: Style.shadowOffsetY)
					
					Text(pet.wrappedName)
						.font(.subheadline)
						.kerning(Style.kerning)
						.fontWeight(.semibold)
						.foregroundColor(Color("TextColor"))
						.multilineTextAlignment(.center)
				}
			}
			.position(location)
			.simultaneousGesture(dragGesture)
			
			
		}
		.animation(Style.springAnimation, value: pet.selected)
		.padding()
		.actionSheet(isPresented: $deletePetConfirmationShowing, content: {
			actionSheet
		})
	}
}


//struct PetsRowView_Previews: PreviewProvider {
//
//	static var previews: some View {
//		//        ContentView()
//		//			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//		let context = PersistenceController.shared.container.viewContext
//		return ContentView().environment(\.managedObjectContext, context)
//	}
//}
