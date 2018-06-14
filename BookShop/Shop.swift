//
//  Shop.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Shop: Object {
	dynamic var id: Int = 0
	dynamic var name: String = ""
	dynamic var address: String = ""
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
