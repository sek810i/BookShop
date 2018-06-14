//
//  Order.swift
//  BookShop
//
//  Created by Богдан Олег on 15.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Order: Object{
	dynamic var idMagazin: Int = 0
	dynamic var idBook: Int = 0
	dynamic var quantity: Int = 0
	
//	override static func primaryKey() -> String?{
//		return "id"
//	}
	
}
