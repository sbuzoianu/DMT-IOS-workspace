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

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
