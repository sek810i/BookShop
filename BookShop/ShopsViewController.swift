//
//  ShopsViewController.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class ShopsViewController: UITableViewController {
	
	let realm = try! Realm()
	let conn = DbCon()
	var currentUser = curUser()
	var listShops = List<Shop>()
	var listBooks = List<Books>()
	var store = List<Store>()
	var idBook: Int = 0
    var shops = [(name:String,address:String,id:Int)]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
		
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
		
		currentUser = conn.loadCurUser()
		listShops = conn.loadShopJSON()
		store = conn.loadStoreJSON()
		listBooks = conn.loadBookJSON()
		
		if idBook != 0 {
			let book = listBooks.first(where: { $0.id == idBook})
			title? = (book?.name)!
				for stor in store {
					if stor.idBook == idBook {
						for shop in listShops{
							if shop.id == stor.idShop{
                                let tmp:(name:String,address:String,id:Int)
								tmp.name = shop.name + " Цена - \(stor.price)"
								tmp.address = shop.address
                                tmp.id = shop.id
								shops.append(tmp)
								break
							}
						}
						break
					}
				}
			
		}
		//tableView.reloadData()
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
		if idBook == 0 {
			return listShops.count
		} else{
			return shops.count
		}
		
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
		
		if idBook != 0 {
			cell.textLabel?.text = "Название: " + shops[indexPath.row].name
			cell.detailTextLabel?.text = "Адрес: " + shops[indexPath.row].address

		} else {
			cell.textLabel?.text = "Название: " + listShops[indexPath.row].name
			cell.detailTextLabel?.text = "Адрес: " + listShops[indexPath.row].address
		}
		

		
		cell.textLabel?.textColor = #colorLiteral(red: 0.8910772204, green: 0.9964497685, blue: 1, alpha: 1)
		cell.detailTextLabel?.textColor = #colorLiteral(red: 0.8910772204, green: 0.9964497685, blue: 1, alpha: 1)
		cell.textLabel?.sizeToFit()
		cell.detailTextLabel?.sizeToFit()
		
		return cell
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
	
	override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
		if let ident = identifier {
			if ident == "goBack" {
				if idBook == 0 {
					return false
				}
			}
		}
		return true
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBack" {
            if let index = self.tableView.indexPathForSelectedRow{
                conn.newOrder(idUser: currentUser.userId, idBook: idBook, idShop: shops[index.row].id)
            }
			let view = segue.destination as! WishTableView
            view.viewDidLoad()
			view.tableView.reloadData()
		}
	}
	
	
}
