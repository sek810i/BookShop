//
//  FilePlist.swift
//  BookShop
//
//  Created by Богдан Олег on 20.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation

import Foundation

class FilePlist{
	var flag: AnyObject? {
		get{
			return UserDefaults.standard.object(forKey: "flag") as AnyObject?
		}
		set{
			UserDefaults.standard.set(newValue,forKey: "flag")
			UserDefaults.standard.synchronize()
		}
	}
}
