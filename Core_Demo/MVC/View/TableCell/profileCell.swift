//
//  profileCell.swift
//  Core_Demo
//
//  Created by Sagar on 13/04/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit

class profileCell: UITableViewCell {

    @IBOutlet weak var imgViewProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
