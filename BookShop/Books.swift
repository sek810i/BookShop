//
//  Books.swift
//  BookShop
//
//  Created by Богдан Олег on 15.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Books: Object{
	dynamic var id: Int = 0
	dynamic var idAvtor: Int = 0
	dynamic var name: String = ""
	dynamic var idGenre: Int = 0
	dynamic var img: String = ""
	dynamic var date: String = ""
	
	override static func primaryKey() -> String?{
		return "id"
	}
}
