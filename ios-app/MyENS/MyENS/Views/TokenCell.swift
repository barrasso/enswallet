//
//  TokenCell.swift
//  MyENS
//
//  Created by mbarrass on 9/9/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit

class TokenCell: UITableViewCell {

    @IBOutlet weak var etherBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.etherBalance.text = ETHManager.shared.etherBalance
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
