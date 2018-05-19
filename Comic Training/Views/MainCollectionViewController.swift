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
    @IBOutlet weak var heroesLoadingActivityIndicator: UIActivityIndicatorView!
    
    var heroesArray: [Hero]? {
        didSet {
            self.collectionView?.reloadData()
            heroesLoadingActivityIndicator.stopAnimating()
        }
    }
    
    let r = Request()
    var errorMessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "ComicTraining"
        
        heroesLoadingActivityIndicator.hidesWhenStopped = true
        heroesLoadingActivityIndicator.startAnimating()
        
        r.delegate = self
        r.requestInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.imageLoadingIndicatorView.hidesWhenStopped = true
        cell.imageLoadingIndicatorView.startAnimating()
        
        if (!hero.hasLoadedImage){
            Alamofire.request((hero.thumbnailPath)).responseImage { response in
                print("\nImage Request for \(hero.name) Response:\n\(response)")
                
                if let image = response.result.value {
                    cell.heroImage.image = image
                    cell.imageLoadingIndicatorView.stopAnimating()
                    self.heroesArray![indexPath.row].thumbnail = image
                    self.heroesArray![indexPath.row].hasLoadedImage = true
                }
            }
        } else {
            cell.heroImage.image = hero.thumbnail
            cell.imageLoadingIndicatorView.stopAnimating()
        }
    
        cell.heroLabel.text = hero.name
        cell.heroLabel.font = UIFont(name: "System Bold", size: CGFloat(17))
        
        return cell
    }
    
    func didLoadHeroes(heroes: [Hero]) {
        if (heroes.count<1){
            showSearchErrorAlert()
        } else {
            heroesArray = heroes
        }
    }
    
    func didFailToLoadHero(withError error: Error) {
        errorMessage = error.localizedDescription
        showRequestErrorAlert()
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
    
    // MARK: Alert Handling
    
    @IBAction func showRequestErrorAlert(){
        let alert = UIAlertController(title: "Request error", message: "\(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: { _ in
            print("Ok pressed")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showSearchErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Sorry, no character to be displayed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: { _ in
            print("Ok pressed")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
