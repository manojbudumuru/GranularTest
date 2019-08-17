
//
//  ImageDataPersistenceUtil.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/16/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImageDataPersistenceUtil {
    
    func fetchFromCoreData() -> IMGDataModel{
        let dataModel : IMGDataModel = IMGDataModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.isEmpty{

            }else{
                for data in result as! [NSManagedObject] {
                    dataModel.imageNameArray = data.value(forKey: nameAttribute) as! [String]
                    dataModel.imageURLArray = data.value(forKey: urlAttribute) as! [String]
                }
            }
        } catch { }
        return dataModel
    }
    
    func isDataPresentInCD() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.isEmpty{
                return false
            }else{
                return true
            }
        } catch {
            return false
        }
    }
    
    func persistDataToCoreData(_ data : IMGDataModel){
        if data.imageNameArray.count > 0 && data.imageURLArray.count > 0{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(data.imageNameArray, forKey: nameAttribute)
            newUser.setValue(data.imageURLArray, forKey: urlAttribute)
            do {
                try context.save()
            } catch { }
        }
        
    }
}
