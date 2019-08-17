//
//  ImageNetworkInterface.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/16/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import Foundation

class ImageNetworkInterface {
    
    var delegate : ImageDataDelegate?
    
    func getImageData(urlValue : String){
        let url : URL = URL(string: urlValue)!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let err = error{
                self.delegate?.imageDataRecieved(imgDataModel: nil, error: err.localizedDescription)
            }else{
                if let resp = responce as? HTTPURLResponse{
                    if resp.statusCode != 200{
                        self.delegate?.imageDataRecieved(imgDataModel: nil, error: "\(resp.statusCode)")
                    }else{
                        if let respData = data{
                            do {
                                let jsonArray : [[String : String]] = try JSONSerialization.jsonObject(with: respData, options: []) as! [[String : String]]
                                let finalData : IMGDataModel = IMGDataModel()
                                finalData.initWith(imageJsonResponce: jsonArray)
                                self.delegate?.imageDataRecieved(imgDataModel: finalData, error: nil)
                            } catch let jsonError as NSError {
                                self.delegate?.imageDataRecieved(imgDataModel: nil, error: jsonError.localizedDescription)
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
