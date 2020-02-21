//
//  AudioItemTableViewCell.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit

class AudioItemTableViewCell: UITableViewCell {

    var cellDelegate: YourCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }
}
