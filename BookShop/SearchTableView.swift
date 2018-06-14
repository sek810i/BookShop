//
//  SearchTableView.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class SearchTableView: UITableViewController, UISearchResultsUpdating {
	
	var searchController = UISearchController(searchResultsController: nil)
	
	let conn = DbCon()
	var listBooks = List<Books>()
	var searchBook = [Books]()
	var arrBook = [Books]()
	var listAvrors = List<Avtors>()
	var searchAvtor = [Avtors]()
	var arrAvtor = [Avtors]()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableHeaderView = searchController.searchBar
		
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.scopeButtonTitles = ["Книги","Авторы"]
		//searchController.searchBar.delegate = self
		
		listBooks = conn.loadBookJSON()
		listAvrors = conn.loadAvtorsJSON()
		title = "Поиск"
		navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)
		
		for book in listBooks{
			arrBook.append(book)
		}
		for avtor in listAvrors{
			arrAvtor.append(avtor)
		}
		
		
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
		if searchController.isActive {
			let searchBar = searchController.searchBar
			let searchType = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
			switch searchType {
			case "Авторы":
				return searchAvtor.count
			case "Книги":
				return searchBook.count
			default:
				return 0
			}
		} else {
			return 0
		}
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
		if searchController.isActive {
			let searchBar = searchController.searchBar
			let searchType = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
			switch searchType {
			case "Авторы":
				cell.textLabel?.text = searchAvtor[indexPath.row].surname + " " + searchAvtor[indexPath.row].name + " " + searchAvtor[indexPath.row].middlename
			case "Книги":
				cell.textLabel?.text = searchBook[indexPath.row].name
			default:
				print("Nope")
			}
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if searchController.isActive{
			return false
		} else {
			return true
		}
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
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	// MARK: - Search
	
	
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text{
			filterContent(searchText: searchText)
			tableView.reloadData()
		}
	}
	
	func filterContent(searchText: String){
		let searchBar = searchController.searchBar
		let searchType = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		switch searchType {
		case "Книги":
			searchBook = arrBook.filter({ (book: Books) -> Bool in
				let nameBook = book.name.range(of: searchText)
				return nameBook != nil
			})
		case "Авторы":
			searchAvtor = arrAvtor.filter({ (avtor: Avtors) -> Bool in
				let nameAvtor = avtor.name.range(of: searchText)
				let famAvtor = avtor.surname.range(of: searchText)
				let otchAvtor = avtor.middlename.range(of: searchText)
				let bornAvtor = avtor.dateBirth.range(of: searchText)
				let deadAvtor = avtor.dateDie.range(of: searchText)
				return nameAvtor != nil || famAvtor != nil || otchAvtor != nil || bornAvtor != nil || deadAvtor != nil
			})
		default:
			print("Error")
		}
	}
	
}
