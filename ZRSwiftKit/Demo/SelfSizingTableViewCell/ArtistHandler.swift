//
//  ArtistHandler.swift
//  MSTabelViewDemo
//
//  Created by jiaxw-mac on 2017/8/29.
//  Copyright © 2017年 jiaxw-mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistHandler {
    class func loadData() -> [ArtistModel] {
        var artistModelList = [ArtistModel]()
        
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artistModelList
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                return artistModelList
            }
            
            guard let artists = rootObject["artists"] as? [[String:AnyObject]] else {
                return artistModelList
            }
            
            for artist in artists {
                if let name = artist["name"] as? String,
                    let bio = artist["bio"] as? String,
                    let image = artist["image"] as? String
                {
                    let item = ArtistModel(name: name, avatar: image, description: bio)
                    artistModelList.append(item)
                }
            }
        } catch  {
            print(error.localizedDescription)
        }
        return artistModelList
    }
    
    class func loadDataWithSwiftyJson() -> [ArtistModel] {
        if let url = Bundle.main.url(forResource: "artists", withExtension: "json"),
            let data = try? Data(contentsOf: url){
            let json = JSON(data: data)
            return json["artists"].arrayValue.map{
                ArtistModel(name: $0["name"].stringValue, avatar: $0["image"].stringValue, description: $0["bio"].stringValue)
            }
        } else {
            return [ArtistModel]()
        }
    }

}
