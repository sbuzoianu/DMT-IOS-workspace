//
//  ClickedOfferDetailViewController.swift
//  DMT
//
//  Created by Racovita Alexandru on 7/18/18.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class ClickedOfferDetailViewController: UIViewController {
    
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerLocationLabel: UILabel!
    var clickedOfferDetailFromServer: ClickedOfferDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offerTitleLabel.text = clickedOfferDetailFromServer?.titluOferta
        self.offerDescriptionLabel.text = clickedOfferDetailFromServer?.descriereOferta
        self.offerLocationLabel.text = clickedOfferDetailFromServer?.numeLocatie
        print("clickedOfferDetailFromServer - \(String(describing: clickedOfferDetailFromServer))")
       
    }

}
