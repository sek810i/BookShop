//
//  AddNewStoreView.swift
//  BookShop
//
//  Created by Богдан Олег on 02.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewStoreView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	
	@IBOutlet weak var nameBook: UITextField!
	@IBOutlet weak var nameShop: UITextField!
	@IBOutlet weak var priceBook: UITextField!
	@IBOutlet weak var piker: UIPickerView!
	@IBOutlet weak var closePicker: UIButton!
	@IBOutlet weak var selectPicker: UIButton!
	
	var conn = DbCon()
	var listShop = List<Shop>()
	var listBook = List<Books>()
	var listStore = List<Store>()
	var books = [(id:Int,name:String)]()
	var shops = [(id:Int,name:String)]()
	var stores = [(book:Int,shop:Int)]()
	var activpic = 0
	var selectBookId = 0
	var selectShopId = 0
	
	@IBAction func addNewStore(_ sender: Any) {
		if (priceBook?.text?.isEmpty)! || selectShopId == 0 || selectBookId == 0 {
			let alert = UIAlertController(title: "Упс!", message: "Поле не может быть пустым\nЗаполни его чем-нибудь", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			if listStore.contains(where: { $0.idShop == selectShopId && $0.idBook == selectBookId }) {
				let alert = UIAlertController(title: "Упс!", message: "Такая книга уже есть в данном магазине\nЗаполни его чем-нибудь", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			} else {
				conn.addStore(idShop: selectShopId, idBook: selectBookId, price: Int((priceBook?.text)!)!)
				let alert = UIAlertController(title: "Ура!", message: "Книга добавлена на склад", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in self.performSegue(withIdentifier: "goBack", sender: self) })
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		listBook = conn.loadBookJSON()
		listShop = conn.loadShopJSON()
		listStore = conn.loadStoreJSON()
		
		 books = [(id:Int,name:String)]()
		 shops = [(id:Int,name:String)]()
		 stores = [(book:Int,shop:Int)]()
		
		for book in listBook {
			let tmp: (id:Int,name:String)
			tmp.id = book.id
			tmp.name = book.name
			books.append(tmp)
		}
		for shop in listShop {
			let tmp: (id:Int,name:String)
			tmp.id = shop.id
			tmp.name = shop.name + "(\(shop.address))"
			shops.append(tmp)
		}
		for store in listStore {
			let tmp: (book:Int,shop:Int)
			tmp.book = store.idBook
			tmp.shop = store.idShop
			stores.append(tmp)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil{
			view.endEditing(true)
		}
		super.touchesBegan(touches, with: event)
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch activpic {
		case 1:
			return books.count
		case 2:
			return shops.count
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch activpic {
		case 1:
			return books[row].name
		case 2:
			return shops[row].name
		default:
			return ""
		}
	}

    

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goBack"{
			let mview = segue.destination as! AdminMenuTableView
			mview.viewDidLoad()
		}
	}
	
	// MARK: - PickerView
	
	@IBAction func selectBook(_ sender: Any) {
		activpic = 1
		piker?.reloadAllComponents()
		piker?.isHidden = false
		closePicker?.isHidden = false
		selectPicker?.isHidden = false
	}

	@IBAction func selectShop(_ sender: Any) {
		activpic = 2
		piker?.reloadAllComponents()
		piker?.isHidden = false
		closePicker?.isHidden = false
		selectPicker?.isHidden = false
	}
	
	@IBAction func closePic(_ sender: Any) {
		piker?.isHidden = true
		closePicker?.isHidden = true
		selectPicker?.isHidden = true
		
	}
	@IBAction func addPic(_ sender: Any) {
		switch activpic {
		case 1:
			nameBook?.text = books[piker.selectedRow(inComponent: 0)].name
			selectBookId = books[piker.selectedRow(inComponent: 0)].id
		case 2:
			nameShop?.text = shops[piker.selectedRow(inComponent: 0)].name
			selectShopId = shops[piker.selectedRow(inComponent: 0)].id
		default:
			print("Nope")
		}
		piker?.isHidden = true
		closePicker?.isHidden = true
		selectPicker?.isHidden = true
	}

}
