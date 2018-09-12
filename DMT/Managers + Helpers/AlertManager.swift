//
//  AlertManager.swift
//  ServerRequestManager
//
//  Created by Synergy on 11/04/18.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import Foundation
import UIKit


class AlertManager: NSObject {
    
    static func showGenericDialog(_ message: String, viewController: UIViewController, closeOnExit: Bool = false, buttonToBeEnabled: UIButton? = nil) {
        
        let alert = UIAlertController(title: "Wrenchy", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            if(buttonToBeEnabled != nil) {
                buttonToBeEnabled?.isEnabled = true;
            } 
            if(closeOnExit) {
                _ = viewController.navigationController?.popViewController(animated: true)
            }
            
        }))
        OperationQueue.main.addOperation {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
 
    static func showGenericDialog(_ message: String, viewController: UIViewController, completionHandler: @escaping () -> Void ) {
        
        let alert = UIAlertController(title: "Wrenchy", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            completionHandler()
            
        })
        alert.addAction(okAction)
        OperationQueue.main.addOperation {
            viewController.present(alert, animated: true, completion: nil)
            
        }
        
    }
}
