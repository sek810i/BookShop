//
//  WishTableView.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class WishTableView: UITableViewController {

	
	let realm = try! Realm()
	let conn = DbCon()
	var curUsr = curUser()
	var listAvtors = List<Avtors>()
	var listGenre = List<Genre>()
	var listBooks = List<Books>()
	var listWish = List<WishList>()
	var idWishBook = [Int]()
    
    @IBAction func goBack(segue: UIStoryboardSegue){
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		listBooks = conn.loadBookJSON()
		listAvtors = conn.loadAvtorsJSON()
		listGenre = conn.loadGenreJSON()
		listWish = conn.loadWishListJSON()
		curUsr = conn.loadCurUser()
		idWishBook = [Int]()
		for wish in listWish{
			if wish.idUser == curUsr.userId{
				idWishBook.append(wish.idBook)
			}
		}
		tableView.reloadData()
		
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
        // #warning Incomplete implementation, return the number of rows
        return idWishBook.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishCell", for: indexPath)  as! WishViewCell
		for book in listBooks{
			if book.id == idWishBook[indexPath.row]{
				for wish in listWish{
					if wish.idBook == book.id && wish.idUser == curUsr.userId {
						print(wish)
                        var state: String
						switch wish.state {
						case 0:
							state = "В списке желаний"
						case 1:
							state = "В корзине"
						case 2:
							state = "Куплена"
						default:
							state = ""
						}
						cell.stateBook.text = state
						break
					}
				}
				
				cell.nameBook.text = "Название: " + book.name
				for avtor in listAvtors {
					if avtor.id == book.idAvtor {
						cell.avtorBook.text = "Автор: " + avtor.surname
						break
					}
				}
				cell.yearBook.text = "Год издания: " + book.date
				cell.imgBook.image = conn.loadImgtoName(name: book.img)
				break
			}
		}
		cell.avtorBook.sizeToFit()
		cell.yearBook.sizeToFit()
		cell.nameBook.sizeToFit()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "selectShop"{
			if let IndexPath = self.tableView.indexPathForSelectedRow{
				let cont = segue.destination as! ShopsViewController
				cont.idBook = idWishBook[IndexPath.row]
				
			}
		}
    }
	

}
