//
//  LoginViewController.swift
//  ServerRequestManager
//
//  Created by Synergy on 27/03/18.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit
import CoreLocation
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userScrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var passwordField: UITextField!
    
    var userDetailsFromServer: UserDetails? = nil
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var prefersStatusBarHidden: Bool{
            return true
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.rememberSwitchState) == true{
            emailField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.savedEmail)
            passwordField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.savedPassword)        }
        rememberSwitch.isOn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.rememberSwitchState)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.isStatusBarHidden = true
        let showKeyboard: (Notification) -> Void = { notification in
            self.keyboardWillShow(notification)
        }
        
        let hideKeyboard: (Notification) -> Void = { notification in
            self.keyboardWillHide(notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow,
                                               object: nil,
                                               queue: nil,
                                               using: showKeyboard)
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide,
                                               object: nil,
                                               queue: nil,
                                               using: hideKeyboard)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.isStatusBarHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didTap(gesture:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                
                return
        }
        let contentInset = UIEdgeInsets(top:0, left: 0, bottom: frame.height+20, right:0)
        userScrollView.contentInset = contentInset
        userScrollView.scrollIndicatorInsets = contentInset
    }
    
    func keyboardWillHide(_ notification: Notification) {
        userScrollView.contentInset = UIEdgeInsets.zero
    }
    

    @IBAction func rememberSwitchPressed(sender: UISwitch){
        print("S-a salvat un nou switchState")
        UserDefaults.standard.set(sender.isOn, forKey: UserDefaultsKeys.rememberSwitchState)
        if sender.isOn == false{
            print("Am sters user defaults")
            UserDefaults.standard.set(emailField.text, forKey: UserDefaultsKeys.noEmail)
            UserDefaults.standard.set(passwordField.text, forKey: UserDefaultsKeys.noPassword)
        } else {
            UserDefaults.standard.set(emailField.text, forKey: UserDefaultsKeys.savedEmail)
            UserDefaults.standard.set(passwordField.text, forKey: UserDefaultsKeys.savedPassword)
            print("Am salvat in user defaults")
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.loginButton.isEnabled = false
        if (emailField.text?.isEmpty)! || passwordField.text?.isEmpty == true{
            self.view.makeToast(ServerRequestConstants.resultErrors.emptyText, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        if (emailField.text?.contains("@"))! == false && emailField.text?.contains(".") == false{
            self.view.makeToast(ServerRequestConstants.resultErrors.invalidEmail, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        
        let mail = emailField.text
        let parola = passwordField.text
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.rememberSwitchState) == true {
            UserDefaults.standard.set(emailField.text, forKey: UserDefaultsKeys.savedEmail)
            UserDefaults.standard.set(passwordField.text, forKey: UserDefaultsKeys.savedPassword)
            print("S-a salvat contul in userdefaults")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let token = appDelegate.instanceIDTokenMessage
        
        var params = Dictionary<String, String>();
        params["mail"] = mail
        params["parola"] = parola
        params["request"] = ServerRequestConstants.JSON.LOGIN_REQUEST_NUMBER
        params["token"] = token
        params["SO"] = "IOS"

        Services.loginService(params: params) { [weak self] result in
            switch result {
            case .success(let json):
                if let responseFromJSON = json.response,
                    let messageFromJSON = json.msg,
                    let resultFromJSON = json.result {
                   
                    switch messageFromJSON {
                    case ServerRequestConstants.JSON.RESPONSE_ERROR :
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                self?.loginButton.isEnabled = true
                                AlertManager.showGenericDialog(responseFromJSON, viewController: self!)
                                
                            }
                        }
                    case ServerRequestConstants.JSON.RESPONSE_SUCCESS:
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                self?.loginButton.isEnabled = true
                                // salvezi resultFromJSON astfel incat el sa fie vizibil pe tot parcursul aplicatiei
                                self?.userDetailsFromServer = resultFromJSON
                                self?.performSegue(withIdentifier: "chooseInterests", sender: (Any).self)

//                                self?.performSegue(withIdentifier: "toApp", sender: (Any).self)
                            }
                        }
                    default:
                        
                        break
                    }
                } else {
                   
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        DispatchQueue.main.async {
                            self?.loginButton.isEnabled = true
                            AlertManager.showGenericDialog(json.response!, viewController: self!)
                        }
                        
                    }
                }
            case .error(let errorString):
                print("errorString = \(errorString)")
                
                break
                
            }
        }
    }
//    override func viewDidLayoutSubviews() {
//          userScrollView.setContentOffset(CGPoint.zero, animated: false)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "toApp" {
                
                let barViewControllers = segue.destination as! UITabBarController
                barViewControllers.viewControllers?.forEach{
                    if let navVC = $0 as? UINavigationController {
                        let tableVC = navVC.viewControllers.first as! HomeViewController
                        tableVC.userDetails = userDetailsFromServer
                        
                    }
                    
                }
                
            } else if segueIdentifier == "chooseInterests" {
                let selectInterestsViewController = segue.destination as! SelectInterestsViewController
                selectInterestsViewController.userDetails = userDetailsFromServer
            }

        }
        segue.destination.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }
    
    
}

extension LoginViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
}


extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if emailField.isFirstResponder{
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            return true
        }
        
        textField.resignFirstResponder()
        return true
    }
}






