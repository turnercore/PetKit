//
//  PetPhotos.swift
//  petkit
//
//  Created by Turner Monroe on 12/13/21.
//

import Foundation
import UIKit

extension PetPhoto {
	
	public var wrappedPhoto: Data {
		photo ?? UIImage(named: "SampleMarci")?.pngData() ?? UIImage(systemName: "photo")?.pngData() ?? UIImage().pngData()!
	}
}
