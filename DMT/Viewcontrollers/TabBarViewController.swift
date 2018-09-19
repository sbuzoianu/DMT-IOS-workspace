//
//  TabBarViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 05/09/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let button = UIButton.init(type: .custom)

    override func viewDidLoad() {

        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.backgroundColor = .red
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.yellow.cgColor
        self.view.insertSubview(button, aboveSubview: self.tabBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let heightValue = CGFloat(50.0)
        let widthValue = CGFloat(50.0)
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: widthValue, height: heightValue)
        button.layer.cornerRadius = button.frame.height/2

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
  

}
