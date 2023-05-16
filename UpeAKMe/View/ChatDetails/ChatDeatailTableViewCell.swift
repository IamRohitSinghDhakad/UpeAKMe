//
//  ChatDeatailTableViewCell.swift
//  MunichBusinessClub
//
//  Created by Rohit Singh Dhakad on 12/01/23.
//

import UIKit

class ChatDeatailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vwOpponent: UIView!
    @IBOutlet weak var vwMyMsg: UIView!
    @IBOutlet weak var lblOpponentMsg: UILabel!
    @IBOutlet weak var lblopponentMsgTime: UILabel!
    @IBOutlet weak var lblMyMsg: UILabel!
    @IBOutlet weak var lblMyMsgTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
