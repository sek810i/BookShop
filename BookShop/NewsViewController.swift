//
//  NewsViewController.swift
//  BookShop
//
//  Created by Богдан Олег on 27.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class NewsViewController: UICollectionViewController {
	
	let realm = try! Realm()
	let conn = DbCon()
	var curUsr = curUser()
	var listAvtors = List<Avtors>()
	var listGenre = List<Genre>()
	var listBooks = List<Books>()
	var listStore = List<Store>()
	var listKorz = List<Korzina>()
	var listWish = List<WishList>()
	var listUser = List<Users>()
	var listShops = List<Shop>()
	
	
	
	
	var idSelectAvtor: Int = 0
	var selectAvtorFlag: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)
		//self.navigationItem.backBarButtonItem?.image = #imageLiteral(resourceName: "Menu")
		//self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: nil, action: nil)
		//self.splitViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: nil, action: nil)
		//navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: nil, action: nil)
		
		//navigationController?.navigationItem.backBarButtonItem?.setBackButtonBackgroundImage(#imageLiteral(resourceName: "Menu"), for: .normal, barMetrics: .defaultPrompt)
		
		listBooks = conn.loadBookJSON()
		listAvtors = conn.loadAvtorsJSON()
		listGenre = conn.loadGenreJSON()
		listShops = conn.loadShopJSON()
		listStore = conn.loadStoreJSON()
		listUser = conn.loadUsersJSON()
		listKorz = conn.loadKorzinaJSON()
		listWish = conn.loadWishListJSON()
		
		
		if selectAvtorFlag == true{
			listAvtors = conn.loadAvtorsJSON()
			for avtr in listAvtors {
				if avtr.id == idSelectAvtor {
					title = avtr.surname
					break
				}
			}
			listBooks = conn.loadBookJSON(idAvtor: idSelectAvtor)
			listGenre = conn.loadGenreJSON()
			} else {
				title = "Книги"
				listBooks = conn.loadBookJSON()
				listAvtors = conn.loadAvtorsJSON()
				listGenre = conn.loadGenreJSON()
			}
		collectionView?.reloadData()
		// self.clearsSelectionOnViewWillAppear = false
		
		// Register cell classes
		//self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	}
	*/
	
	// MARK: UICollectionViewDataSource
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
		return listBooks.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsViewCell
		
		
		
		cell.nameBook.text! = listBooks[indexPath.row].name
		cell.nameBook.sizeToFit()
		for avtor in listAvtors {
			if avtor.id == listBooks[indexPath.row].idAvtor{
				cell.avtorBook.text! = avtor.name + " " + avtor.surname
				break
			}
		}
		cell.avtorBook.sizeToFit()
		cell.imgBook!.image = conn.loadImgtoName(name: listBooks[indexPath.row].img)
		cell.BookId = listBooks[indexPath.row].id
		
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	
	/*
	// Uncomment this method to specify if the specified item should be highlighted during tracking
	override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/
	
	/*
	// Uncomment this method to specify if the specified item should be selected
	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
	return true
	}
	*/
	
	/*
	// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
	override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
	return false
	}
	
	override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
	return false
	}
	
	override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
	
	}
	*/
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "dopInfo"{
			if let indexPath = self.collectionView?.indexPath(for: sender as! NewsViewCell)
			{
				let nav = segue.destination as! UINavigationController
				let controller: InfoBookViewController = nav.topViewController as! InfoBookViewController
				controller.idbook = listBooks[indexPath.row].id
				controller.title = listBooks[indexPath.row].name
			}
			//controller.idbook = bookCell.BookId
		}
		
	}
	
}
