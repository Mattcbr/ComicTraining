//
//  MainCollectionViewController.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "mainCollectionViewCell"

class MainCollectionViewController: UICollectionViewController, RequestDelegate {
    
    var heroesArray: [Hero]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    let r = Request()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "ComicTraining"
        r.delegate = self
        r.requestInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! MainCollectionViewCell
        var selectedIndexPath = self.collectionView?.indexPath(for: cell)
        let destination = segue.destination as! DetailsViewController
        
        let selectedHero: Hero = heroesArray![(selectedIndexPath?.row)!]
        
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        
        destination.hero = selectedHero
        navigationItem.backBarButtonItem = backItem
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heroesArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {
            fatalError("Not a main collection view cell")
        }
    
        let hero: Hero = (heroesArray![indexPath.row])
        
        Alamofire.request((hero.thumbnailPath)).responseImage { response in
            print("\nImage Request for \(hero.name) Response:\n\(response)")
            
            if let image = response.result.value {
                cell.heroImage.image = image
            }
        }
    
        cell.heroLabel.text = hero.name
        cell.heroLabel.font = UIFont(name: "System Bold", size: CGFloat(17))
        
        return cell
    }
    
    func didLoadHeroes(heroes: [Hero]) {
        heroesArray = heroes
    }
    
    func didFailToLoadHero(withError error: Error) {
        print("Error: \(error)")
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

}
