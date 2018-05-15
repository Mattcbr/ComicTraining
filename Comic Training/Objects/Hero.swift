//
//  Hero.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import Foundation
import UIKit

struct Hero {
    
    let name: String
    let description: String
    let thumbnailPath: String
    let comicsCount: Int
    let comics: [Comic]
    var thumbnail: UIImage
    var hasLoadedImage: Bool
    
    init(name: String, desc: String, thumbPath: String, comicsCount: Int, comics: [Comic]) {
        self.name = name
        self.description = desc
        self.comicsCount = comicsCount
        self.thumbnailPath = thumbPath
        self.comics = comics
        self.thumbnail = UIImage(named: "Marvel-logo-2")!
        self.hasLoadedImage = false
    }
}
