//
//  KorzinaCell.swift
//  BookShop
//
//  Created by Богдан Олег on 01.03.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class KorzinaCell: UITableViewCell {

	@IBOutlet weak var nameBook: UILabel!
	@IBOutlet weak var nameShop: UILabel!
	@IBOutlet weak var priceBook: UILabel!
	@IBOutlet weak var stateOrder: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
