//
//  SwiftUIView.swift
//  petkit
//
//  Created by Turner Monroe on 12/12/21.
//

import Foundation
import CoreData
import SwiftUI


extension Pet {
	
	public var wrappedName: String {
		get { name ?? "Unknown Name"}
		set { self.name = newValue }
	}
	
	public var wrappedProfilePhoto: Data {
		get {
			if profile == nil {
				return UIImage(systemName: "photo")?.pngData() ?? UIImage().pngData()!
			} else {
				return self.profile!.photo!
			}
		}
		set { self.profile?.photo = newValue }
		
	}
}
