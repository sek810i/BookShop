//
//  KorzinaView.swift
//  BookShop
//
//  Created by Богдан Олег on 01.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class KorzinaView: UITableViewController {
	
	@IBOutlet weak var qwe: UIBarButtonItem!
	
	let realm = try! Realm()
	let conn = DbCon()
	var curUsr = curUser()
	var listAvtors = List<Avtors>()
	var listBooks = List<Books>()
	var listWish = List<WishList>()
	var listShops = List<Shop>()
	var listKorzina = List<Korzina>()
	var listStore = List<Store>()
	var wishCurUser = [WishList]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		listWish = conn.loadWishListJSON()
		listBooks = conn.loadBookJSON()
		listShops = conn.loadShopJSON()
		listKorzina = conn.loadKorzinaJSON()
		listStore = conn.loadStoreJSON()
		curUsr = conn.loadCurUser()
		for wish in listWish{
			if wish.idUser == curUsr.userId && wish.state != 0 {
				wishCurUser.append(wish)
			}
		}
		wishCurUser.sort { $0.state < $1.state }
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return wishCurUser.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "KorzinaCell", for: indexPath)  as! KorzinaCell
		let wish = wishCurUser[indexPath.row]
		let korzina = listKorzina.first(where: { $0.idBook == wish.idBook && $0.idUser == wish.idUser})
		cell.nameBook.text = "Книга: " + (listBooks.first(where: { $0.id == wish.idBook })?.name)!
		cell.nameShop.text = "Магазин: " + (listShops.first(where: { $0.id == korzina?.idShop})?.name)!
		cell.priceBook.text = "Цена: \((listStore.first(where: { $0.idShop == korzina?.idShop && $0.idBook == wish.idBook })?.price)!)"
		var state: String
		switch wish.state {
		case 0:
			state = "В списке желаний"
		case 1:
			state = "В корзине"
			cell.backgroundColor = #colorLiteral(red: 0, green: 0.5650748014, blue: 0.3169043064, alpha: 1)
		case 2:
			state = "Куплена"
			cell.backgroundColor = #colorLiteral(red: 0, green: 0.404035349, blue: 0.2632228414, alpha: 1)
		default:
			state = ""
		}
		cell.stateOrder.text = state
		
		return cell
	}
	
	
	//	performSegue(withIdentifier: "goBackSpis", sender: self)
	//
	//	print(" уже тут")
	//}
	
	@IBAction func SellBook(_ sender: Any) {
		if wishCurUser.contains(where: { $0.state == 1 }) {
			for tov in wishCurUser {
				conn.newSell(idUser: curUsr.userId, idBook: tov.idBook)
			}
			let alert = UIAlertController(title: "Ура!", message: "Заказы были отправленны по магазинам\nПокупайте ещё", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBackSpis", sender: self) })
			self.present(alert, animated: true, completion: nil)
		} else {
			let alert = UIAlertController(title: "Упс!", message: "Вы купили все книги из корзины\nДля покупки добавте что-нибудь ещё", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBackSpis", sender: self) })
			self.present(alert, animated: true, completion: nil)
		}
		
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBackSpis" {
			let view = segue.destination as! WishTableView
            view.viewDidLoad()
			view.tableView.reloadData()
		}
	}
	
	
}
