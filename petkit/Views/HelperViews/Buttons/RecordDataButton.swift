//
//  RecordDataButton.swift
//  petkit
//
//  Created by Turner Monroe on 12/15/21.
//

import SwiftUI

struct RecordDataButton: View {
	var buttonText: Text?
	var buttonImage: Image?
	
	
	var body: some View {
		Button
		{
			print("RecordDataButton pressed")
		} label: {
			VStack {
				buttonImage ?? Image("")
				buttonText ?? Text("")
			}
		}
	}
}


struct RecordDataButton_Previews: PreviewProvider {
	static var previews: some View {
		RecordDataButton(buttonText: Text("Hello world"), buttonImage: Image(systemName: "checkmark"))
	}
}


