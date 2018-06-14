//
//  MenuViewController.swift
//  BookShop
//
//  Created by Богдан Олег on 11.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UITableViewController {

	var user = curUser()
	var conn = DbCon()
    var realm = try! Realm()
	var autflag: Bool = false
	
	@IBOutlet var menuTable: UITableView!
 
    @IBOutlet weak var ExitCell: UITableViewCell!
	
	@IBOutlet weak var avtorizationCell: UITableViewCell!
	@IBOutlet weak var korzinaCell: UITableViewCell!
	
	@IBAction func goBack(segue: UIStoryboardSegue){
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		user = conn.loadCurUser()
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)
		
		if user.userId == 0 {
			korzinaCell?.isHidden = true
			avtorizationCell?.isHidden = false
            ExitCell?.isHidden = true
			tableView.reloadData()
            
		} else {
			avtorizationCell?.isHidden = true
			korzinaCell?.isHidden = false
            ExitCell?.isHidden = false
			tableView.reloadData()
			//navigationController?.removeFromParentViewController()
			
		}

		
		//navigationItem.hidesBackButton = false
        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

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

    //override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    // #warning Incomplete implementation, return the number of rows
    //    return 10
    //}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "logout" {
            try! realm.write {
                realm.delete(user)
            }
            self.viewDidLoad()
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
