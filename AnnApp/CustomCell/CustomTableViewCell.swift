//
//  CustomTableViewCell.swift
//  AnnApp
//
//  Created by Anel Hadzic on 22/06/2018.
//  Copyright © 2018 Anel Hadzic. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var moviePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
