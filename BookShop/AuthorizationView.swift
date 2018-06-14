//
//  AuthorizationView.swift
//  BookShop
//
//  Created by Богдан Олег on 26.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class AuthorizationView: UIViewController {
	
	let realm = try! Realm()
	let conn = DbCon()
	var file = FilePlist()
	var listUsers = List<Users>()
	var currentUser = curUser()
	
	@IBOutlet weak var LoginType: UISegmentedControl!
	@IBOutlet weak var LoginField: UITextField!
	@IBOutlet weak var PasswordField: UITextField!
	@IBOutlet weak var RegButton: UIButton!

	
	
	
	@IBAction func LogIn(_ sender: Any) {
		print("Put")
		
		if LoginField.text?.isEmpty == true || PasswordField.text?.isEmpty == true {
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			if LoginType.selectedSegmentIndex == 0 {
				listUsers = conn.loadUsersJSON()
				for user in listUsers {
					if user.name == LoginField.text && user.password == PasswordField.text{
						currentUser.userId = user.id
						currentUser.userName = user.name
						currentUser.userType = user.type
						try! self.realm.write {
							self.realm.add(currentUser, update: true)
						}
						//self.removeFromParentViewController()
						//dismiss(animated: true, completion: nil)
						if user.type == "admin" {
							performSegue(withIdentifier: "goAdmin", sender: self)
						} else {
							performSegue(withIdentifier: "MenuShow", sender: self)
						}
						
						
						break
					}
				}
				if currentUser.userName.isEmpty == true{
					let alert = UIAlertController(title: "Упс!", message: "Не верный логин или пароль\n или такого пользователя не существует", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
					self.present(alert, animated: true, completion:nil)
				}
			}
		}
	}
	
	@IBAction func ChangeLogin(_ sender: Any) {
		if LoginType.selectedSegmentIndex == 1{
			RegButton.isHidden = false
		} else {
			RegButton.isHidden = true
		}
	}
	
	@IBAction func addNewUser(_ sender: Any) {
		if LoginField.text?.isEmpty == true || PasswordField.text?.isEmpty == true {
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			var existflag: Bool = false
			for val in listUsers {
				if val.name == LoginField!.text{
					existflag = true
				}
			}
			if existflag == true {
				let alert = UIAlertController(title: "Упс!", message: "Такой пользователь уже существует\nПопробуй ввести другой логин", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.newuser(login: LoginField.text!, password: PasswordField.text!)
				let alert = UIAlertController(title: "Ура!", message: "Новый пользователь добавлен. Можешь войти", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
				LoginType.selectedSegmentIndex = 0
				listUsers = conn.loadUsersJSON()
				RegButton.isHidden = true
			}
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		listUsers = conn.loadUsersJSON()
		if LoginType.selectedSegmentIndex == 0{
			RegButton.isHidden = true
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "MenuShow"{
			//let nav = segue.destination as! UINavigationController
			//let controller = nav.topViewController as! MenuViewController
			let controller = segue.destination as! MenuViewController
			controller.autflag = true
			controller.viewDidLoad()
		}
	}
	
	
}
