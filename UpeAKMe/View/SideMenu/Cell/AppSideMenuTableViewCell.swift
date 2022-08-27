//
//  AppSideMenuTableViewCell.swift
//  Paing
//
//  Created by Akshada on 21/05/21.
//

import UIKit

class AppSideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet var lblBadgeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblBadgeCount.layer.cornerRadius = self.lblBadgeCount.layer.bounds.width / 2
        self.lblBadgeCount.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
