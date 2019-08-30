//
//  TableViewCell.swift
//  ChatApp
//
//  Created by Anil Kumar on 12/09/18.
//  Copyright © 2018 Anil Kumar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ImageIcon: UIImageView!
    @IBOutlet weak var receiver: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
