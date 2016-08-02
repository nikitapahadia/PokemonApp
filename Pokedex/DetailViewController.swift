//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Nikita Pahadia on 7/27/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UITableViewController {
	var pokemon: Pokemon!
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var type: UILabel!
	@IBOutlet weak var summary: UILabel!
	@IBOutlet weak var evolutions: UILabel!
	@IBOutlet weak var favourite: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		hidesBottomBarWhenPushed = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = pokemon.name
		let share = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(sharedTapped))
		let readmore = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: #selector(readMoreTapped))
		navigationItem.rightBarButtonItems = [share, readmore]
		
		imageView.image = UIImage(named: pokemon.name)
		nameLabel.text = pokemon.name
		type.text = pokemon.type
		summary.text = pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary + pokemon.summary
		if pokemon.evolutions.count > 0 {
			evolutions.text = "\(pokemon.name) > " + pokemon.evolutions.joinWithSeparator(" > ")
		} else {
			evolutions.text = "\(pokemon.name)"
		}
		
		setFavorites()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if indexPath.row == 3 {
			return UITableViewAutomaticDimension
		}
		else {
			return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
		}
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		guard indexPath.row == 5  else { return }
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		let defaults = NSUserDefaults.standardUserDefaults()
		var favorites = defaults.objectForKey("favorites") as? [String] ?? [String]()
		if let index = favorites.indexOf(pokemon.name) {
			favorites.removeAtIndex(index)
		} else {
			favorites.append(pokemon.name)
		}
		defaults.setObject(favorites, forKey: "favorites")
		setFavorites()
		
	}
	
	func sharedTapped() {
		let vc = UIActivityViewController(activityItems: [pokemon.summary, imageView.image!], applicationActivities: nil)
		presentViewController(vc, animated: true, completion: nil)
	}
	
	func readMoreTapped() {
		if let url = NSURL(string: "http://pokemondb.net/pokedex/\(pokemon.name)") {
			let vc = SFSafariViewController(URL: url)
			presentViewController(vc, animated: true, completion: nil)
		}
	}
	
	func setFavorites() {
		let defaults = NSUserDefaults.standardUserDefaults()
		let favorites = defaults.objectForKey("favorites") as? [String] ?? [String]()
		if favorites.contains(pokemon.name) {
			favourite.text = "Remove from Favorites"
		} else {
			favourite.text = "Add to favorites"
		}
	}
	
}
