//
//  AddNewAvtorView.swift
//  BookShop
//
//  Created by Богдан Олег on 02.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewAvtorView: UIViewController {

	@IBOutlet weak var fam: UITextField!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var otch: UITextField!
	@IBOutlet weak var dateBorn: UITextField!
	@IBOutlet weak var dateDead: UITextField!
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}
	
	@IBAction func addAvtor(_ sender: Any) {
		if (fam?.text?.isEmpty)! ||
			(name?.text?.isEmpty)! ||
			(otch?.text?.isEmpty)! ||
			(dateBorn?.text?.isEmpty)! ||
			(dateDead?.text?.isEmpty)!{
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			if listAvtors.contains(where: { $0.name == name?.text && $0.surname == fam?.text && $0.middlename == otch?.text && $0.dateBirth == dateBorn?.text && $0.dateDie == dateDead?.text }){
				let alert = UIAlertController(title: "Упс!", message: "Такой автор уже есть\nЗаполни его чем-нибудь", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.addAvtor(fam: (fam?.text)!, name: (name?.text)!, otch: (otch?.text)!, dateBorn: (dateBorn?.text)!, dateDie: (dateDead?.text)!)
				let alert = UIAlertController(title: "Ура!", message: "Автор добавлен", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBack", sender: self) })
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
	
	var realm = try! Realm()
	var listAvtors = List<Avtors>()
	var conn = DbCon()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		listAvtors = conn.loadAvtorsJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
    // MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBack"{
			let mview = segue.destination as! AdminMenuTableView
			mview.viewDidLoad()
		}
	}
	

}
