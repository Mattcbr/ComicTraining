//
//  DetailsViewController.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var hero = Hero(name: "", desc: "", thumbPath: "", comicsCount: 0, comics: [Comic]()) {
        didSet{
            print("Hero set: \(hero.name)")
        }
    }
    var heroImage = UIImage()
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heroNameLabel.text = hero.name
        heroImageView.image = heroImage
        heroDescription.numberOfLines = 0
        
//        hero.description == "" ? heroDescription.text = "Description not available for this character" : heroDescription.text = hero.description

       if hero.description == ""{
            heroDescription.text = "Description not available for this character"
        } else {
            heroDescription.text = hero.description
        }
        
//        heroDescription.text = hero.description
        heroDescription.sizeToFit()
        
        self.navigationItem.title = hero.name
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
