//
//  Avtors.swift
//  BookShop
//
//  Created by Богдан Олег on 15.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Avtors: Object {
	dynamic var id: Int = 0
	dynamic var name: String = ""
	dynamic var surname: String = ""
	dynamic var middlename: String = ""
	dynamic var dateBirth: String = ""
	dynamic var dateDie: String = ""
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
