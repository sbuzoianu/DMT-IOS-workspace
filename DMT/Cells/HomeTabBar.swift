//
//  HomeTabBar.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 05/09/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class HomeTabBar: UITabBar {

    private var middleButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMiddleButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = middleButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
    }
    
    func setupMiddleButton() {
        middleButton.frame.size = CGSize(width: 60, height: 60)
        middleButton.backgroundColor = .blue
        middleButton.layer.cornerRadius = 35
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        middleButton.addTarget(self, action: #selector(tapMiddleButton), for: .touchUpInside)
        addSubview(middleButton)
    }
    
    @objc func tapMiddleButton() {
        print("sunt cel mai dragut middle button")
    }
}
