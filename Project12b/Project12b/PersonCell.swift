//
//  PersonCell.swift
//  Project12b
//
//  Created by Erik Radicheski da Silva on 12/06/22.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        nameLabel.text = nil
    }
}
