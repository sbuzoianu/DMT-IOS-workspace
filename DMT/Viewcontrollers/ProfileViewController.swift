//
//  ProfileViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 18/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var segmentedReviews: UISegmentedControl!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var  userDetails: UserDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedReviews.layer.shadowColor = UIColor.black.cgColor
        segmentedReviews.layer.shadowOffset = CGSize(width: 0, height: 4)
        segmentedReviews.layer.shadowRadius = 4
        segmentedReviews.layer.shadowOpacity = 0.25
        
        print(userDetails?.avatar as Any)
        if userDetails?.avatar != "" {		
            let avatar = userDetails?.avatar?.fromBase64()
            profileImageView.image = avatar
            profileImageView.image = profileImageView.image?.resizeWith(width: 130.0)
            profileImageView.image = profileImageView.image?.circle
        }
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapImage)
        profileImageView.isUserInteractionEnabled = true
        

    }
    
    
    @objc func imageTapped(sender: UIImageView){
        print("ImageView Tapped!")
        let controller = UIImagePickerController()
        controller.delegate = self 
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = image
        profileImageView.image = profileImageView.image?.resizeWith(width: 130.0)
        profileImageView.image = profileImageView.image?.circle
        let imageStr = ServerRequestHelper.instance.convertImageTobase64(format: .png, image: image)
        dismiss(animated: true, completion: nil)
        var params = Dictionary<String, String>();
        params["request"] = "1"
        params["avatar"] = imageStr
        Services.avatarChange(params: params) { [weak self] result in
            switch result {
            case .success(let json):
                if let responseFromJSON = json.response,
                    let messageFromJSON = json.msg {
                    
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
                                print("success")
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
}

