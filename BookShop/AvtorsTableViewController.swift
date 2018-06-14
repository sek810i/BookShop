//
//  AvtorsTableViewController.swift
//  BookShop
//
//  Created by Богдан Олег on 20.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift


class AvtorsTableViewController: UITableViewController {
	
	let realm = try! Realm()
	let conn = DbCon()
	var file = FilePlist()
	var listAvtors = List<Avtors>()

    override func viewDidLoad() {
		listAvtors = conn.loadAvtorsJSON()
		super.viewDidLoad()
		
		self.title = "Авторы"
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)
		

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return listAvtors.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Avtorscell", for: indexPath) as! AvtorCell
		
		cell.nameAvtor.text = listAvtors[indexPath.row].name + " " + listAvtors[indexPath.row].middlename + " " + listAvtors[indexPath.row].surname
		cell.dateBorn.text = "Родился: " + listAvtors[indexPath.row].dateBirth
		cell.dateDead.text =  "Умер: " + listAvtors[indexPath.row].dateDie
		cell.nameAvtor.sizeToFit()
		cell.dateBorn.sizeToFit()
		cell.dateDead.sizeToFit()
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
		if segue.identifier == "BooksToAvtor"{
			if let indexPath = self.tableView.indexPathForSelectedRow{
				//let nav = segue.destination as! UINavigationController
				//let controller = nav.topViewController as! NewsViewController
				let controller = segue.destination as! NewsViewController
				controller.selectAvtorFlag = true
				controller.idSelectAvtor = listAvtors[indexPath.row].id
			}
		}
    }


}
