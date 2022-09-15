//
//  CountryTableViewCell.swift
//  Consolidation06
//
//  Created by Erik Radicheski da Silva on 15/09/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailContent: UILabel!
    
    var detail: (title: String, content: Any)? {
        didSet {
            if let detail = detail {
                detailTitle.text = detail.title
                detailContent.text = "\(detail.content)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        detailTitle.text = nil
        detailContent.text = nil
    }
    
}
