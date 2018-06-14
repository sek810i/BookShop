//
//  InfoBookViewController.swift
//  BookShop
//
//  Created by Богдан Олег on 27.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

class InfoBookViewController: UIViewController {
	
	
	@IBOutlet weak var imgBook: UIImageView!
	@IBOutlet weak var avtorBook: UILabel!
	@IBOutlet weak var genreBook: UILabel!
	@IBOutlet weak var yearBook: UILabel!
	
	
	var idbook: Int = 0
	let realm = try! Realm()
	let conn = DbCon()
	var curUsr = curUser()
	var listAvtors = List<Avtors>()
	var listGenre = List<Genre>()
	var listBooks = List<Books>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		listBooks = conn.loadBookJSON()
		listAvtors = conn.loadAvtorsJSON()
		listGenre = conn.loadGenreJSON()
		
		for book in listBooks{
			if book.id == idbook{
				imgBook.image = conn.loadImgtoName(name: book.img)
				yearBook.text = "Год издания: " + book.date
				for gen in listGenre{
					if book.idGenre == gen.id {
						genreBook!.text = "Жанр: " + gen.name
						break
					}
				}
				for avt in listAvtors{
					if avt.id == book.idAvtor {
						avtorBook!.text = "Автор: " + avt.name + " " + avt.middlename + " " + avt.surname
						break
					}
				}
				break
			}
		}
		avtorBook.sizeToFit()
		genreBook.sizeToFit()
		yearBook.sizeToFit()
		
	}
	
	@IBAction func AddWithList(_ sender: Any) {
		curUsr = conn.loadCurUser()
		if curUsr.userId == 0{
			let alert = UIAlertController(title: "Упс!", message: "Вы не зарегестрированы\nДля добавления в список желаний надо зарегестрироватся", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion:nil)
		} else {
			let listWish = conn.loadWishListJSON()
			if listWish.count == 0{
				conn.newWish(idUser: curUsr.userId, idBook: idbook)
				let alert = UIAlertController(title: "ЕЕЕЕЕ РОК!", message: "Книга в желаниях", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion:nil)
			}else{
				if listWish.contains(where: {$0.idBook == idbook && $0.idUser == curUsr.userId}){
					let alert = UIAlertController(title: "Упс!", message: "Постойте\nВы когда то уже добавляли эту книгу в список желаний", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
					self.present(alert, animated: true, completion:nil)
				} else {
					conn.newWish(idUser: curUsr.userId, idBook: idbook)
					let alert = UIAlertController(title: "ЕЕЕЕЕ РОК!", message: "Книга в желаниях", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
					self.present(alert, animated: true, completion:nil)
				}
				
			}
		}
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
