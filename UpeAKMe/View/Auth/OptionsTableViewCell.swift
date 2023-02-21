//
//  OptionsTableViewCell.swift
//  ServiLine
//
//  Created by Rohit Singh Dhakad on 23/03/22.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var vwBorder: UIView!
    @IBOutlet var vwTick: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
