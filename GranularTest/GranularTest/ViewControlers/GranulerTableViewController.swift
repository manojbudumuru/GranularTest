//
//  GranulerTableViewController.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/16/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import UIKit

class GranulerTableViewController: UITableViewController {

    var nameArray : [String] = []
    var imgURLArray : [String] = []
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data : IMGDataModel = ImageDataManager.shared.imgDataModel{
            self.nameArray = data.imageNameArray
            self.imgURLArray = data.imageURLArray
            self.tableView.reloadData()
        }
        
        self.tableView.register(UINib(nibName: "CustomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgURLArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomeTableViewCell
        if self.imgURLArray.count > 0{
            cell.nameLBL.text = self.nameArray[indexPath.row]
            if let originalImage : UIImage = self.imageCache.object(forKey: self.imgURLArray[indexPath.row] as NSString){
                cell.cellImage.image = originalImage
            }else{
                cell.cellImage.image = UIImage(named: "placeHolderImage.png")
                if let imageURL = URL(string: "\(imagePartURL)\(self.imgURLArray[indexPath.row])"){
                    URLSession.shared.dataTask(with: imageURL) { (data, responce, error) in
                        if error == nil{
                            if let respData = data{
                                DispatchQueue.main.async {
                                    if let originalImage : UIImage = UIImage(data: respData){
                                        cell.cellImage.image = originalImage
                                        self.imageCache.setObject(originalImage, forKey: self.imgURLArray[indexPath.row] as NSString)
                                    }
                                }
                            }
                        }
                    }.resume()
                }
            }
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
