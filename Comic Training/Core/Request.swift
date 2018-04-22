//
//  Request.swift
//  Comic Training
//
//  Created by Matheus Queiroz on 4/22/18.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import Foundation

import Alamofire

protocol RequestDelegate: class{
    func didLoadHeroes(heroes: [Hero])
    func didFailToLoadHero(withError error: Error)
}

class Request {
    
    weak var delegate: RequestDelegate?
    
    func requestInfo() {
        
        //Info needed to handle the request security
        let ts = String(Date().ticks)
        let publicKey: String = "49d87eaa6caa8f3b2c167bf0192a975e"
        let privateKey: String = "3beaaf1ec20b7742f099683318556694c67e4ae9"
        let tbHash = ts+privateKey+publicKey
        let hash = MD5(string: tbHash)
        let hashHex = hash.map{String(format: "%02hhx", $0)}.joined()
        
        let requestURL = "https://gateway.marvel.com:443/v1/public/characters?limit=20&ts=\(ts)&apikey=49d87eaa6caa8f3b2c167bf0192a975e&hash=\(hashHex)"
        
        let p = Parser()
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let heroesArray = p.parseInfo(response: JSON)
                self.delegate?.didLoadHeroes(heroes: heroesArray)
            case .failure(let error):
                self.delegate?.didFailToLoadHero(withError: error)
            }
        }
    }
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData
    }
}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
