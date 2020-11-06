//
//  SettingsTableCell.swift
//  iBuy
//
//  Created by Cesar A. Tavares on 04/11/20.
//

import UIKit

class SettingsTableCell: UITableViewCell {

    @IBOutlet weak var labelSettings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(settings: String) {
        labelSettings.text = settings
    }

}
