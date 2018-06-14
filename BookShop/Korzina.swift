//
//  Korzina.swift
//  BookShop
//
//  Created by Богдан Олег on 01.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Korzina: Object{
	dynamic var id: Int = 0
	dynamic var idUser: Int = 0
	dynamic var idShop: Int = 0
	dynamic var idBook: Int = 0
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
