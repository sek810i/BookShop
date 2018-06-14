//
//  Users.swift
//  BookShop
//
//  Created by Богдан Олег on 26.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Users: Object{
	dynamic var id: Int = 0
	dynamic var name: String = ""
	dynamic var password: String = ""
	dynamic var type: String = ""
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
