//
//  WishViewCell.swift
//  BookShop
//
//  Created by Богдан Олег on 28.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class WishViewCell: UITableViewCell {

	@IBOutlet weak var imgBook: UIImageView!
	@IBOutlet weak var nameBook: UILabel!
	@IBOutlet weak var avtorBook: UILabel!
	@IBOutlet weak var yearBook: UILabel!
	@IBOutlet weak var stateBook: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
