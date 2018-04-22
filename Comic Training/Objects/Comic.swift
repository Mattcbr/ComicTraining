//
//  Comic.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import Foundation

struct Comic {
    
    let name: String
    let path: String
    
    init(name: String, path: String) {
        self.name  = name
        self.path = path
    }
}
