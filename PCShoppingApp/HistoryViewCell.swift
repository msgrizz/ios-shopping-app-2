//
//  HistoryViewCell.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/26/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import UIKit

class HistoryViewCell: UITableViewCell {
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var genreImage: UIImageView!
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
