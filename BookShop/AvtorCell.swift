//
//  AvtorCell.swift
//  BookShop
//
//  Created by Богдан Олег on 27.02.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class AvtorCell: UITableViewCell {

	@IBOutlet weak var nameAvtor: UILabel!
	@IBOutlet weak var dateBorn: UILabel!
	@IBOutlet weak var dateDead: UILabel!
	
	
	var idAvtor: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
