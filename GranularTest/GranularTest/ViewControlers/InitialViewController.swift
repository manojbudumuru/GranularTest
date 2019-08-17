//
//  InitialViewController.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/16/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var imageNetworkInterface : ImageNetworkInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageNetworkInterface = ImageNetworkInterface()
        self.imageNetworkInterface?.delegate = self
    }
    
    @IBAction func getImageData(_ sender: Any) {
        if ImageDataPersistenceUtil().isDataPresentInCD(){
            ImageDataManager.shared.imgDataModel = ImageDataPersistenceUtil().fetchFromCoreData()
            self.navigateToTableView()
        }else{
            self.imageNetworkInterface?.getImageData(urlValue: dataURL)
        }
    }
    
    func navigateToTableView() {
        self.performSegue(withIdentifier: initialSEGUE, sender: self)
    }
    
}

extension InitialViewController : ImageDataDelegate{
    func imageDataRecieved(imgDataModel: IMGDataModel?, error: String?) {
        if let errString = error{
            DispatchQueue.main.async {
                self.showNetworkError(errorMSG: errString)
            }
        }else if let data = imgDataModel{
            ImageDataManager.shared.imgDataModel = data
            ImageDataPersistenceUtil().persistDataToCoreData(data)
            DispatchQueue.main.async {
                self.navigateToTableView()
            }
        }
    }
    
    func showNetworkError(errorMSG : String) {
        let alertView : UIAlertController = UIAlertController(title: networkErrorTitle, message: errorMSG, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
}
