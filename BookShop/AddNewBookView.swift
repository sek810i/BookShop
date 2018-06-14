//
//  AddNewBookView.swift
//  BookShop
//
//  Created by Богдан Олег on 02.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewBookView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var nameBook: UITextField!
	@IBOutlet weak var avtorBook: UITextField!
	@IBOutlet weak var GanreBook: UITextField!
	@IBOutlet weak var yearBook: UITextField!
	@IBOutlet weak var picker: UIPickerView!
	@IBOutlet weak var donePicker: UIButton!
	@IBOutlet weak var backPicker: UIButton!
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}
	
	let realm = try! Realm()
	let conn = DbCon()
	var curUsr = curUser()
	var listAvtors = List<Avtors>()
	var listGenre = List<Genre>()
	var listBooks = List<Books>()
	var avrors = [(id:Int,name:String)]()
	var genre = [(id:Int,name:String)]()
	var activpic = 0
	var selectAvtorId = 0
	var selectGenreId = 0
	
	@IBAction func addNewBook(_ sender: Any) {
		if (nameBook?.text?.isEmpty)! || selectAvtorId == 0 || selectGenreId == 0 || (yearBook?.text?.isEmpty)! {
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			if listBooks.contains(where: { $0.idAvtor == selectAvtorId && $0.name == nameBook?.text && $0.idGenre == selectGenreId && $0.date == yearBook?.text}){
				let alert = UIAlertController(title: "Упс!", message: "Такая книга уже есть\nЗаполни его чем-нибудь", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.addBook(idAvtor: selectAvtorId, name: (nameBook?.text)!, date: (yearBook?.text)!, idGenre: selectGenreId)
				let alert = UIAlertController(title: "Ура!", message: "Книга добавлена", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBack", sender: self) })
				self.present(alert, animated: true, completion: nil)
			}
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		listBooks = conn.loadBookJSON()
		listAvtors = conn.loadAvtorsJSON()
		listGenre = conn.loadGenreJSON()
		picker?.isHidden = true
		donePicker?.isHidden = true
		backPicker?.isHidden = true
		
		avrors = [(id:Int,name:String)]()
		for av in listAvtors{
			let tmp: (id:Int,name:String)
			tmp.id = av.id
			tmp.name = av.surname + " " + av.name
			avrors.append(tmp)
		}
		
		genre = [(id:Int,name:String)]()
		for g in listGenre{
			let tmp: (id:Int,name:String)
			tmp.id = g.id
			tmp.name = g.name
			genre.append(tmp)
		}
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch activpic {
		case 1:
			return avrors.count
		case 2:
			return genre.count
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch activpic {
		case 1:
			return avrors[row].name
		case 2:
			return genre[row].name
		default:
			return ""
		}
	}
	
	
	
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBack"{
			let mview = segue.destination as! AdminMenuTableView
			mview.viewDidLoad()
		}
	}
	
	@IBAction func avtorPicker(_ sender: Any) {
		activpic = 1
		picker?.reloadAllComponents()
		picker?.isHidden = false
		donePicker?.isHidden = false
		backPicker?.isHidden = false
		
		
	}
	
	
	@IBAction func genrePicker(_ sender: Any) {
		activpic = 2
		picker?.reloadAllComponents()
		picker?.isHidden = false
		donePicker?.isHidden = false
		backPicker?.isHidden = false
		
	}
	
	@IBAction func closePicker(_ sender: Any) {
		picker?.isHidden = true
		donePicker?.isHidden = true
		backPicker?.isHidden = true
	}
	
	@IBAction func aplyPicker(_ sender: Any) {
		switch activpic {
		case 1:
			avtorBook?.text = avrors[picker.selectedRow(inComponent: 0)].name
			selectAvtorId = avrors[picker.selectedRow(inComponent: 0)].id
		case 2:
			GanreBook?.text = genre[picker.selectedRow(inComponent: 0)].name
			selectGenreId = genre[picker.selectedRow(inComponent: 0)].id
		default:
			print("Nope")
		}
		picker?.isHidden = true
		donePicker?.isHidden = true
		backPicker?.isHidden = true
	}
	
}
