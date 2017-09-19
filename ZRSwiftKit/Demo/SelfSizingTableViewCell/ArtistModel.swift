//
//  ArtistModel.swift
//  MSTabelViewDemo
//
//  Created by jiaxw-mac on 2017/8/29.
//  Copyright © 2017年 jiaxw-mac. All rights reserved.
//

import UIKit

class ArtistModel {
    
    /// 姓名
    let name: String
    
    
    /// 头像
    let avatar: String
    
    
    /// 描述
    let description :String
    
    
    init(name:String,avatar:String,description:String) {
        self.name = name
        self.avatar = avatar
        self.description = description
    }

}
