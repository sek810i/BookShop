//
//  DbConnect.swift
//  BookShop
//
//  Created by Богдан Олег on 15.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift


class DbCon {
	
	let realm = try! Realm()
	var file = FilePlist()
	
	func loadAvtorsJSON() -> List<Avtors> {
		
		let avtors = List<Avtors>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Avtors"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let avtor = Avtors()
					avtor.id = subJson["id"].intValue
					avtor.name = subJson["name"].stringValue
					avtor.surname = subJson["surname"].stringValue
					avtor.middlename = subJson["middlename"].stringValue
					avtor.dateBirth = subJson["date_birth"].stringValue
					avtor.dateDie = subJson["date_die"].stringValue
					avtors.append(avtor)
				}
				
				// парсим лист
				
				try! self.realm.write {
					self.realm.add(avtors, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpAvtors = self.realm.objects(Avtors.self)
		let outAvtors = List<Avtors>()
		for val in tmpAvtors {
			outAvtors.append(val)
		}
		return outAvtors
	}
	
	func loadUsersJSON() -> List<Users> {
		
		let users = List<Users>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Users"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let user = Users()
					user.id = subJson["id"].intValue
					user.name = subJson["user"].stringValue
					user.password = subJson["password"].stringValue
					user.type = subJson["type"].stringValue
					users.append(user)
				}
				
				try! self.realm.write {
					self.realm.add(users, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpUsers = self.realm.objects(Users.self)
		let outUsers = List<Users>()
		for val in tmpUsers {
			outUsers.append(val)
		}
		return outUsers
	}
	
	func loadBookJSON() -> List<Books> {
		
		let books = List<Books>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Books"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					print(subJson)
					let book = Books()
					book.id = subJson["id"].intValue
					book.idAvtor = subJson["id_avtor"].intValue
					book.name = subJson["name"].stringValue
					book.date = subJson["date_book"].stringValue
					book.idGenre = subJson["id_genre"].intValue
					book.img = subJson["img"].stringValue
					books.append(book)
				}
				
				try! self.realm.write {
					self.realm.add(books, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpBooks = self.realm.objects(Books.self)
		let outBooks = List<Books>()
		for val in tmpBooks {
			outBooks.append(val)
		}
		return outBooks
	}
	
	func loadBookJSON(idAvtor: Int) -> List<Books> {
		
		let books = List<Books>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Books"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					print(subJson)
					let book = Books()
					book.id = subJson["id"].intValue
					book.idAvtor = subJson["id_avtor"].intValue
					book.name = subJson["name"].stringValue
					book.date = subJson["date_book"].stringValue
					book.idGenre = subJson["id_genre"].intValue
					book.img = subJson["img"].stringValue
				}
				
				try! self.realm.write {
					self.realm.add(books, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpBooks = self.realm.objects(Books.self)
		let outBooks = List<Books>()
		for val in tmpBooks {
			if val.idAvtor == idAvtor{
				outBooks.append(val)
			}
		}
		return outBooks
	}
	
	
	func loadGenreJSON() -> List<Genre> {
		
		let genres = List<Genre>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Genre"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let genre = Genre()
					genre.id = subJson["idGenre"].intValue
					genre.name = subJson["Genre"].stringValue
					genres.append(genre)
				}
				
				try! self.realm.write {
					self.realm.add(genres, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpGenres = self.realm.objects(Genre.self)
		let outGenres = List<Genre>()
		for val in tmpGenres {
			outGenres.append(val)
		}
		return outGenres
	}
	
	
	func newuser(login: String, password: String) {
		let url = "http://bookshop.sek810i.ru/newuser.php"
		let param = ["logn":login,"pwd":password]
		
		_ = Alamofire.request(url,parameters: param)
	}
	
	func newWish(idUser: Int, idBook: Int) {
		let url = "http://bookshop.sek810i.ru/newWish.php"
		let param = ["idBook":idBook,"idUser":idUser]
		
		_ = Alamofire.request(url,parameters: param)
	}
	
	func newSell(idUser: Int, idBook: Int) {
		let url = "http://bookshop.sek810i.ru/Sell.php"
		let param = ["idBook":idBook,"idUser":idUser]
		
		_ = Alamofire.request(url,parameters: param)
	}
	
	func newOrder(idUser: Int, idBook: Int, idShop:Int) {
		let url = "http://bookshop.sek810i.ru/newOrder.php"
		let param = ["idBook":idBook,"idUser":idUser,"idShop":idShop]
		
		_ = Alamofire.request(url,parameters: param)
	}
	//===============
	func addBook(idAvtor: Int, name: String, date: String, idGenre: Int) {
		let url = "http://bookshop.sek810i.ru/addBook.php"
		let param = ["idAvtor":idAvtor,
		             "name":name,
		             "date":date,
		             "idgenre":idGenre] as [String : Any]
		
		_ = Alamofire.request(url,parameters: param)
	}
	func addAvtor(fam:String,
	              name:String,
	              otch:String,
	              dateBorn:String,
	              dateDie:String) {
		let url = "http://bookshop.sek810i.ru/addAvtor.php"
		let param = ["surname":fam,
		             "name":name,
		             "middlename":otch,
		             "dateBirth":dateBorn,
		             "dateDie":dateDie]
		
		_ = Alamofire.request(url,parameters: param)
	}
	func addGenre(name: String) {
		let url = "http://bookshop.sek810i.ru/addGenre.php"
		let param = ["name":name]
		
		_ = Alamofire.request(url,parameters: param)
	}
	func addStore(idShop:Int, idBook:Int, price: Int) {
		let url = "http://bookshop.sek810i.ru/addStore.php"
		let param = ["idShop":idShop,"idBook":idBook,"price":price]
		
		_ = Alamofire.request(url,parameters: param)
	}
	func addShop(name: String, address: String) {
		let url = "http://bookshop.sek810i.ru/addShops.php"
		let param = ["name":name,"address":address]
		
		_ = Alamofire.request(url,parameters: param)
	}
	//================
	func loadImgtoName(name: String) -> UIImage {
		var img = UIImage()
		let url = NSURL(string: "http://bookshop.sek810i.ru/img/\(name)")
		
		let dataimg = NSData(contentsOf: url! as URL)
		if dataimg != nil {
			img = UIImage(data: dataimg! as Data)!
		}
		
		
		return img
	}
	
	func loadCurUser() -> curUser {
		let firstuser = curUser()
		try! self.realm.write {
			self.realm.add(firstuser, update: true)
		}
		let user = self.realm.objects(curUser.self)
		return user.last!
		
	}
	
	func loadShopJSON() -> List<Shop> {
		
		let shops = List<Shop>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Shops"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let shop = Shop()
					shop.id = subJson["id"].intValue
					shop.name = subJson["name"].stringValue
					shop.address = subJson["address"].stringValue
					shops.append(shop)
				}
				
				try! self.realm.write {
					self.realm.add(shops, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpShops = self.realm.objects(Shop.self)
		let outShops = List<Shop>()
		for val in tmpShops {
			outShops.append(val)
		}
		return outShops
	}
	
	
	func loadWishListJSON() -> List<WishList> {
		
		let wishLists = List<WishList>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"WishList"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let wishList = WishList()
					wishList.id = subJson["id"].intValue
					wishList.idBook = subJson["idBook"].intValue
					wishList.idUser = subJson["idUser"].intValue
					wishList.state = subJson["State"].intValue
					wishLists.append(wishList)
				}
				
				try! self.realm.write {
					self.realm.add(wishLists, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpWishList = self.realm.objects(WishList.self)
		let outWishList = List<WishList>()
		for val in tmpWishList {
			outWishList.append(val)
		}
		return outWishList
	}
	
	func loadStoreJSON() -> List<Store> {
		
		let listStore = List<Store>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Store"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let store = Store()
					store.id = subJson["id"].intValue
					store.idBook = subJson["id_book"].intValue
					store.idShop = subJson["id_magazine"].intValue
					store.price = subJson["price"].intValue
					listStore.append(store)
				}
				
				try! self.realm.write {
					self.realm.add(listStore, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpStore = self.realm.objects(Store.self)
		let outStore = List<Store>()
		for val in tmpStore {
			outStore.append(val)
		}
		return outStore
	}
	
	func loadKorzinaJSON() -> List<Korzina> {
		
		let listStore = List<Korzina>()
		let url = "http://bookshop.sek810i.ru/service.php"
		let param = ["table":"Orders"]
		
		Alamofire.request(url, parameters: param).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print(json.count)
				for(_,subJson):(String,JSON) in json{
					let store = Korzina()
					store.id = subJson["id"].intValue
					store.idBook = subJson["id_book"].intValue
					store.idShop = subJson["id_magazine"].intValue
					store.idUser = subJson["id_user"].intValue
					listStore.append(store)
				}
				
				try! self.realm.write {
					self.realm.add(listStore, update: true)
				}
			//self.file.flag = true as AnyObject?
			case .failure(let error):
				print(error)
			}
		}
		let tmpStore = self.realm.objects(Korzina.self)
		let outStore = List<Korzina>()
		for val in tmpStore {
			outStore.append(val)
		}
		return outStore
	}

	
	
}
