//
//  CustomeTableViewCell.swift
//  GranularTest
//
//  Created by manoj budumuru on 8/17/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
