//
//  AddNewGenreView.swift
//  BookShop
//
//  Created by Богдан Олег on 02.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewGenreView: UIViewController {
	
	
	@IBOutlet weak var nameField: UITextField!
	
	var realm = try! Realm()
	var listGen = List<Genre>()
	var conn = DbCon()
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}
	
	@IBAction func addGenre(_ sender: Any) {
		if (nameField?.text?.isEmpty)! {
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else{
			if listGen.contains(where: { $0.name == nameField?.text}){
				let alert = UIAlertController(title: "Упс!", message: "Такой жанр уже есть\nЗаполни его чем-нибудь", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.addGenre(name: (nameField?.text)!)
				let alert = UIAlertController(title: "Ура!", message: "Жанр добавлен", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBack", sender: self) })
				self.present(alert, animated: true, completion: nil)
				performSegue(withIdentifier: "goBack", sender: self)
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		listGen = conn.loadGenreJSON()
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
