//
//  OffersCollectionViewCell.swift
//  DMT
//
//  Created by Boggy on 08/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit



class OffersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    static let ReuseIdentifier = String(describing: OffersCollectionViewCell.self)
    static let NibName = String(describing: OffersCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func load() {
        priceLabel.text = "75"
        headerLabel.text = "da"
        jobLabel.text = "padurar"
    }
    
    
    
}

