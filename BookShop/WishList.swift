//
//  WishList.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class WishList: Object {
	dynamic var id: Int = 0
	dynamic var idUser: Int = 0
	dynamic var idBook: Int = 0
	dynamic var state: Int = 0
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
