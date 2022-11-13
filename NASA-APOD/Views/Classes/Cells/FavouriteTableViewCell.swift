//
//  FavouriteTableViewCell.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(favourite: [String: Any]) {
        titleLabel.text = favourite["title"] as? String
        dateLabel.text = (favourite["date"] as? String)?.toDate(format: "MMMM dd, yyyy")
    }
}
