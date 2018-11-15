//
//  ImageTitleTableViewCell.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 15/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class ImageTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var UICellImage: UIImageView!
    @IBOutlet weak var UICellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
