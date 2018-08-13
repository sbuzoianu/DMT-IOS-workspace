//
//  OfferDetailsViewCell1.swift
//  DMT
//
//  Created by Boggy on 23/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit
protocol OffersTableViewCellProtocol {
    func config(withData:Any)
}

class OfferDetailsTableViewCell1: UITableViewCell, OffersTableViewCellProtocol {

    func config(withData: Any) {
        let data = withData as! cellData
        self.headerLabel.text = data.text
        self.dateLabel.text = "BUBU"
        self.priceLabel.text = "10 RON"
    }
    
    static let ReuseIdentifier = String(describing: OfferDetailsTableViewCell1.self)
    static let NibName = String(describing: OfferDetailsTableViewCell1.self)
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
