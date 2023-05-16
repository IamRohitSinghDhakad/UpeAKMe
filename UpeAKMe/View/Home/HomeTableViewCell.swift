//
//  HomeTableViewCell.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 14/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var imgVw: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTimeAgo: UILabel!
    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
