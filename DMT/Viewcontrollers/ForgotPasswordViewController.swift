//
//  ForgotPasswordViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 28/05/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userScrollView: UIScrollView! 
    
    var emailConfirmationTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        view.addGestureRecognizer(tapGesture)
        emailTextField.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
        let showKeyboard: (Notification) -> Void = { notification in
            self.KeyboardWillShow(notification)
        }
        
        let hideKeyboard: (Notification) -> Void = { notification in
            self.KeyboardWillHide(notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow,
                                               object: nil,
                                               queue: nil,
                                               using: showKeyboard)
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide,
                                               object: nil,
                                               queue: nil,
                                               using: hideKeyboard)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didTap(gesture:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func KeyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                
                return
        }
        let contentInset = UIEdgeInsets(top:0, left: 0, bottom: frame.height + 20, right:0)
        userScrollView.contentInset = contentInset
        userScrollView.scrollIndicatorInsets = contentInset
    }
    
    func KeyboardWillHide(_ notification: Notification) {
        userScrollView.contentInset = UIEdgeInsets.zero
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func changePasswordButton(_ sender: Any) {
        emailTextField.resignFirstResponder()
        if (emailTextField.text?.isEmpty)! {
            self.view.makeToast(ServerRequestConstants.resultErrors.emptyText, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        
        if (emailTextField.text?.contains("@"))! == false && emailTextField.text?.contains(".") == false{
            self.view.makeToast(ServerRequestConstants.resultErrors.invalidEmail, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        var params = Parameters()
        params["request"] = "0"
        params["mail"] = emailTextField.text
      	
        Services.forgotPasswordService(params: params) { [weak self] result in
            switch result {
            case .success(let json):
                if let responseFromJSON = json.response,
                    let messageFromJSON = json.msg
                {
                    
                    switch messageFromJSON {
                    case ServerRequestConstants.JSON.RESPONSE_ERROR :
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                AlertManager.showGenericDialog(responseFromJSON, viewController: self!)
                                
                            }
                        }
                    case ServerRequestConstants.JSON.RESPONSE_SUCCESS:
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                AlertManager.showGenericDialog(responseFromJSON, viewController: self!)
                                
                            }
                        }
                    default:
                        break
                    }
                }
                
            case .error(let errorString):
                print("errorString = \(errorString)")
                
                break
                
            }
        }
        
    }
    
    func emailConfirmationTextField(textField: UITextField!) {
        emailConfirmationTextField = textField
        emailConfirmationTextField?.placeholder = "Validation Code"
    }
    
    func okHandler(alert: UIAlertAction) {
        
        
    }
    
    func createAlert(msg: String?){
        let alertController = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: emailConfirmationTextField)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: self.okHandler)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
