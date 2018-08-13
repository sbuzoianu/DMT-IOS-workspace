//
//  OfferCollectionViewCell.swift
//  DMT
//
//  Created by Boggy on 26/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {

    
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var headerLabel: UILabel!
//    @IBOutlet weak var jobLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel? //if the user wants to be displayed
    
    static let ReuseIdentifier = String(describing: OfferCollectionViewCell.self)
    static let NibName = String(describing: OfferCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func load() {
        priceLabel.text = "75"
        headerLabel.text = "da"
        jobLabel.text = "padurar"
    }
    
    
    
}
