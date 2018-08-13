//
//  RegisterViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 28/04/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var userScrollView: UIScrollView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var profileImageView: UIImageView!
    var clickedOfferDetailFromServer: ClickedOfferDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        view.addGestureRecognizer(tapGesture)
        
        profileImageView.addGestureRecognizer(tapImage)
        profileImageView.isUserInteractionEnabled = true
        
        emailField.delegate = self
        passwordField.delegate = self
        nameField.delegate = self
        phoneField.delegate = self
        
    }
    
    @objc func imageTapped(sender: UIImageView){
        print("ImageView Tapped!")
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        print("text field = \(String(describing: notification.userInfo))")
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                
                return
        }
        let contentInset = UIEdgeInsets(top:0, left: 0, bottom: frame.height + 10, right:0)
        
        userScrollView.contentInset = contentInset
        userScrollView.scrollIndicatorInsets = contentInset
    }
    
    func KeyboardWillHide(_ notification: Notification) {
        userScrollView.contentInset = UIEdgeInsets.zero
    }
    
   
    
    @IBAction func registerButton(_ sender: Any) {
        if (emailField.text?.isEmpty)! == true ||
            passwordField.text?.isEmpty == true ||
            nameField.text?.isEmpty == true ||
            phoneField.text?.isEmpty == true {
            //            resultLabel.text = ServerRequestConstants.resultErrors.emptyText
            //            resultLabel.textColor = UIColor.white
            self.view.makeToast(ServerRequestConstants.resultErrors.emptyText, duration: 3.0, position:.bottom, title: "Error")
            return
        }
        if (emailField.text?.contains("@"))! == false && emailField.text?.contains(".") == false{
            //            resultLabel.text = ServerRequestConstants.resultErrors.invalidEmail
            //            resultLabel.textColor = UIColor.white
            self.view.makeToast(ServerRequestConstants.resultErrors.invalidEmail, duration: 3.0, position:.bottom, title: "Error")
            return
        }
        if phoneField.text?.isNumeric == false {
            self.view.makeToast(ServerRequestConstants.resultErrors.invalidPhoneNumber, duration: 3.0, position:.bottom, title: "Error")
            return
        }
        let imageStr = ServerRequestHelper.instance.convertImageTobase64(format: .png, image: profileImageView.image!)
        
        let phoneNumber = phoneField.text
        let email = emailField.text
        let password = passwordField.text
        let fullName = nameField.text
        
        var params = Dictionary<String, String>();
        params["nume"] = fullName
        params["prenume"] = "empty"
        params["tip"] = "1"
        params["mail"] = email
        params["avatar"] = imageStr
        params["parola"] = password
        params["telefon"] = phoneNumber
        params["request"] = ServerRequestConstants.JSON.REGISTER_REQUEST_NUMBER
        
        Services.registerService(params: params) { [weak self] result in
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
                                AlertManager.showGenericDialog(ServerRequestConstants.resultErrors.confirmEmail, viewController: self!)
                                
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
    
}
extension UIImage{
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailField.isFirstResponder{
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }
        if passwordField.isFirstResponder{
            textField.resignFirstResponder()
            nameField.becomeFirstResponder()
        }
        if nameField.isFirstResponder{
            textField.resignFirstResponder()
            phoneField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = image
        profileImageView.image = profileImageView.image?.resizeWith(width: 130.0)
        profileImageView.image = profileImageView.image?.circle
        
        dismiss(animated: true, completion: nil)
    }
}

