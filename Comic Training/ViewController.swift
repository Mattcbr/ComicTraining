//
//  ViewController.swift
//  Comic Training
//
//  Created by Matheus Castelo on 12/01/2018.
//  Copyright © 2018 Matheus Castelo. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import AlamofireObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestInfo()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UIProperties
    /*@IBOutlet weak var heroesCollectionView: UICollectionView!{
    
    }*/
    
    //MARK: API Request
    func requestInfo() {
        
        let ts = String(Date().ticks)
//        print ("TS: \(ts)")
        
        let publicKey: String = "49d87eaa6caa8f3b2c167bf0192a975e"
        let privateKey: String = "3beaaf1ec20b7742f099683318556694c67e4ae9"
        
        let tbHash = ts+privateKey+publicKey
        
        let hash = MD5(string: tbHash)
//        print("hash: \(hash)")
        
        let hashHex = hash.map{String(format: "%02hhx", $0)}.joined()
//        print("hashHex: \(hashHex)")
        
        let requestURL = "https://gateway.marvel.com:443/v1/public/characters?limit=20&ts=\(ts)&apikey=49d87eaa6caa8f3b2c167bf0192a975e&hash=\(hashHex)"
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
                case .success(let JSON):
                    let JSONresponse = JSON as? [String : Any]
                    
                    let data = JSONresponse?["data"] as? [String : Any]
                    let values = data?["results"] as? [[String : Any]]
                    
                    var nameArray = [String]()
                    var ThumbArray = [String]()
                    
                    let respCount: Int = values!.count
                    
                    for i in 0...(respCount-1)
                    {
                        //Varre heroi por heroi
                        let hero = values?[i]
                        
                        //Coleta o nome de cada
                        let name = hero?["name"] as? String
                        
                        //Coleta o caminho da imagem de cada
                        let thumbnail = hero?["thumbnail"] as? [String : Any]
                        let path = thumbnail?["path"] as? String
                        let ext = thumbnail?["extension"] as? String
                        let thumbpath = "\(path!).\(ext!)"
                        
                        nameArray.append(name!)
                        ThumbArray.append(thumbpath)
                    }
                
                    print(nameArray)
                
                case .failure(let error):
                    print("Falhou com erro: \(error)")
            }
        
            print(response)
            
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

