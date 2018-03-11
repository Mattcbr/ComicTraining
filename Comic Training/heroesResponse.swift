//
//  heroesResponse.swift
//  Comic Training
//
//  Created by Matheus Castelo on 16/02/2018.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import Foundation
import ObjectMapper

class heroesResponse: Mappable {
    var results: [Hero]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class Hero: Mappable {
    var name: String?
    var thumbnailPath: URL?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        thumbnailPath <- map["thumbnail.path"]
    }
}
