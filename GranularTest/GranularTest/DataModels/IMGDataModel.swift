//
//  IMGDataModel.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/16/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import Foundation


class IMGDataModel{
    var imageURLArray : [String] = []
    var imageNameArray : [String] = []
    
    init() {    }
    
    func initWith(imageJsonResponce : [[String : String]]) {
        if imageJsonResponce.count > 0 && !imageJsonResponce.isEmpty{
            for dict : [String : String] in imageJsonResponce{
                if !dict.isEmpty{
                    imageURLArray.append(dict[urlKey] ?? "")
                    imageNameArray.append(dict[nameKey] ?? "")
                }
            }
            print("----------\(imageNameArray)----------")
            print("----------\(imageURLArray)----------")
        }
    }
    
    
}
