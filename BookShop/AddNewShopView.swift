//
//  AddNewShopView.swift
//  BookShop
//
//  Created by Богдан Олег on 02.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewShopView: UIViewController {
	
	
	@IBOutlet weak var nameShop: UITextField!
	@IBOutlet weak var addressShop: UITextField!
	
	var realm = try! Realm()
	var listShops = List<Shop>()
	var conn = DbCon()
	
	@IBAction func addShop(_ sender: Any) {
		if (nameShop?.text?.isEmpty)! || (addressShop?.text?.isEmpty)!{
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			if listShops.contains(where: { $0.name == nameShop?.text && $0.address == addressShop?.text } ) {
				let alert = UIAlertController(title: "Упс!", message: "Такой магазин уже есть\nЗаполни его чем-нибудь", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.addShop(name: (nameShop?.text)!, address: (addressShop?.text)!)
				let alert = UIAlertController(title: "Ура!", message: "Магазин добавлен", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBack", sender: self) })
				self.present(alert, animated: true, completion: nil)
			}
		}
		
	}
	
    
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		listShops = conn.loadShopJSON()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBack"{
			let mview = segue.destination as! AdminMenuTableView
			mview.viewDidLoad()
		}
    }


}
