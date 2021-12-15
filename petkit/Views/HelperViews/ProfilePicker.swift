//
//  ProfilePicker.swift
//  petkit
//
//  Created by Turner Monroe on 12/13/21.
//

import SwiftUI

struct ImagePickerSwiftUI: UIViewControllerRepresentable {
	@Environment(\.presentationMode) private var presentationMode
	@Binding var selectedImage: UIImage
	var sourceType: UIImagePickerController.SourceType = .photoLibrary

	public init(selectedImage: Binding<UIImage>, sourceType: UIImagePickerController.SourceType) {
		self._selectedImage = selectedImage
		self.sourceType = sourceType
	}

	public func makeUIViewController(context: Context) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = false
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator

		return imagePicker
	}
	
	public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
		
	}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		var parent: ImagePickerSwiftUI
		
		init(_ parent: ImagePickerSwiftUI) {
			self.parent = parent
		}
		
		public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			
			if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
				parent.selectedImage = image
			}
			
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
}

struct ProfilePicker: View {
	
	
    var body: some View {
        Text("Hello, World!")
    }
}

struct ProfilePicker_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicker()
    }
}
