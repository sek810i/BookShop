//
//  curUser.swift
//  BookShop
//
//  Created by Богдан Олег on 26.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class curUser: Object {
	dynamic var userId: Int = 0
	dynamic var userName: String = ""
	dynamic var userType: String = ""
	//dynamic var orders: Order = Order()
	
	override static func primaryKey() -> String?{
		return "userId"
	}
}
