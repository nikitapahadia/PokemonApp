//
//  FavouritesViewController.swift
//  Pokedex
//
//  Created by Nikita Pahadia on 7/27/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import UIKit

class FavouritesViewController: UICollectionViewController {
	var favorites = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Favorites"
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		let defaults = NSUserDefaults.standardUserDefaults()
		let favs = defaults.objectForKey("favorites") as? [String] ?? [String]()
		if favs != favorites {
			favorites = favs
			collectionView?.reloadData()
		}
	}
	
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favorites.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath)
		let pokemon = favorites[indexPath.row]
		if let imageView =  cell.viewWithTag(7) as? UIImageView {
			imageView.image = UIImage(named: pokemon)
		}
		return cell
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
