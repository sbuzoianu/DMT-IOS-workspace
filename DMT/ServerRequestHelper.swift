//
//  ServerRequestHelper.swift
//  ServerRequestManager
//
//  Created by Synergy on 11/04/18.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import Foundation
import UIKit

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

class ServerRequestHelper:NSObject {
      static let instance = ServerRequestHelper()
    
    func createGradientLayer(start startColor:UIColor, final finalColor: UIColor, viewController: UIViewController) {
        
        let gradient = CAGradientLayer()
        gradient.frame = viewController.view.bounds
        gradient.colors = [startColor.cgColor, finalColor.cgColor] 
        
        viewController.view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func isEmail(_ currentString:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]+$", options: NSRegularExpression.Options.caseInsensitive)
            return regex.firstMatch(in: currentString, options: [], range: NSMakeRange(0, currentString.count)) != nil
        } catch { return false }
    }
    
    func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(image)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(image, compression)
        }
        return imageData?.base64EncodedString()
    }
    
}
extension UIViewController{
    
    /// Calculate top distance with "navigationBar" and "statusBar" by adding a
    /// subview constraint to navigationBar or to topAnchor or superview
    /// - Returns: The real distance between topViewController and Bottom navigationBar
    func calculateTopDistance() -> CGFloat{
        
        /// Create view for misure
        let misureView : UIView     = UIView()
        misureView.backgroundColor  = .clear
        view.addSubview(misureView)
        
        /// Add needed constraint
        misureView.translatesAutoresizingMaskIntoConstraints                    = false
        misureView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive     = true
        misureView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive   = true
        misureView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        if let nav = navigationController {
            misureView.topAnchor.constraint(equalTo: nav.navigationBar.bottomAnchor).isActive = true
        }else{
            misureView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        /// Force layout
        view.layoutIfNeeded()
        
        /// Calculate distance
        let distance = view.frame.size.height - misureView.frame.size.height
        
        /// Remove from superview
        misureView.removeFromSuperview()
        
        return distance
        
    }
    
}
extension String {
 
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

extension UINavigationBar {
    func setTransparent(_ flag: Bool) {
        if flag == true {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
            backgroundColor = .clear
            isTranslucent = true
        } else {
            setBackgroundImage(nil, for: .default)
        }
    }
}
