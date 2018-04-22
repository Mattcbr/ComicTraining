//
//  Parser.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import Foundation

class Parser {
    
    func parseInfo(response: Any) -> [Hero]{
        let JSONresponse = response as? [String : Any]
        
        let data = JSONresponse?["data"] as? [String : Any]
        let values = data?["results"] as? [[String : Any]]
        
        var heroesArray = [Hero]()
        
        values?.forEach { newHero in
            //Array to save comics of each hero
            var comicsArray = [Comic]()
            
            //Colects name of each hero
            let name = newHero["name"] as? String
            
            //Colects the image path for each hero
            let thumbnail = newHero["thumbnail"] as? [String : Any]
            let path = thumbnail?["path"] as? String
            let ext = thumbnail?["extension"] as? String
            let thumbpath = "\(path!).\(ext!)"
            
            //Colects the comics of this hero
            let comicsList = newHero["comics"] as? [String: Any]
            let comicsCount = comicsList?["returned"] as? Int
            let comics = comicsList?["items"] as? [[String: Any]]
            comics?.forEach { comic in
                let comicName = comic["name"] as? String
                let comicPath = comic["resourceURI"] as? String
                
                let newComic = Comic(name: comicName!, path: comicPath!)
                comicsArray.append(newComic)
            }
            
            //Creates a person and saves it in an array of people
            let hero = Hero(name: name!,
                            thumbPath: thumbpath,
                            comicsCount: comicsCount!,
                            comics: comicsArray)
            
            heroesArray.append(hero)
        }
        return heroesArray
    }
}
