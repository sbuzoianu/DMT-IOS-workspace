//
//  SelectInterestsViewController.swift
//  DMT
//
//  Created by Synergy on 06/09/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class SelectInterestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var userDetails: UserDetails? // aceasta instanta este creata atunci cand se va face tranzitia din LoginVC in SelectInterestsVC

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func doneButton(_ sender: Any) {
        let paramInterestsArray = selectedInterestsValues.filter{$0 != "0"}
        let paramInterestsString = paramInterestsArray.compactMap{ $0 }.joined(separator: ",")
        
        var params = [String:Any]()
        
        params["request"] = "1"
        params["id_user"] = userDetails?.idUser
        params["stergere"] = ""
        
        print("paramInterestsArray = \(paramInterestsArray)") // paramInterestsArray = ["3", "9"]
        print("csv = \(paramInterestsString)") // csv = 3,9
        params["adaugare"] = paramInterestsString   //["1","2"]

        Services.chooseSpecializations(params: params) { [weak self] result in
            switch result {
            case .success(let json):

                guard let responseFromJSON = json.response else {
                    return
                }
                guard let messageFromJSON = json.msg else {
                    return
                }

                switch messageFromJSON {
                case ServerRequestConstants.JSON.RESPONSE_ERROR :
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        DispatchQueue.main.async {
                            AlertManager.showGenericDialog("ERROR - Interests adding operation = \(responseFromJSON)", viewController: self!)
                        }
                    }
                case ServerRequestConstants.JSON.RESPONSE_SUCCESS:
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        DispatchQueue.main.async {

                            AlertManager.showGenericDialog("SUCCESS - Interests adding operation = \(responseFromJSON)", viewController: self!,completionHandler: {
                                    self?.performSegue(withIdentifier: "toApp", sender: (Any).self)
                                print("BUBU")
                            })

                        }
                    }
                default:
                    break
                }

            case .error(let errorString):
                print("errorString = \(errorString)")

                break

            }
        }
        
        
        
    }
    var selectedInterestsValues = [String]()
    
    let interestsName = ["Babysitting", "Cleaning", "Cooking", "Electrician", "Gardener", "HousePainter", "Mechanic", "Plumber", "Shopping", "Add"]
    
    let interestsImage = [UIImage(named: "Babysitting")!,
                          UIImage(named: "Cleaning")!,
                          UIImage(named: "Cooking")!,
                          UIImage(named: "Electrician")!,
                          UIImage(named: "Gardener")!,
                          UIImage(named: "HousePainter")!,
                          UIImage(named: "Mechanic")!,
                          UIImage(named: "Plumber")!,
                          UIImage(named: "Shopping")!,
                          UIImage(named: "Add" )!]
    

    
    let interestsImageSELECTED = [UIImage(named: "BabysittingSELECTED")!,
                                  UIImage(named: "CleaningSELECTED")!,
                                  UIImage(named: "CookingSELECTED")!,
                                  UIImage(named: "ElectricianSELECTED")!,
                                  UIImage(named: "GardenerSELECTED")!,
                                  UIImage(named: "HousePainterSELECTED")!,
                                  UIImage(named: "MechanicSELECTED")!,
                                  UIImage(named: "PlumberSELECTED")!,
                                  UIImage(named: "ShoppingSELECTED")!,
                                  UIImage(named: "Add" )!]
    
    let imageView : UIImageView = {
        let backgroundImageCollectionView = UIImageView()
        backgroundImageCollectionView.image = UIImage(named:"HomeBG")
        backgroundImageCollectionView.contentMode = .scaleAspectFill
        return backgroundImageCollectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView?.backgroundView = imageView
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Choose your interests"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy),
            .foregroundColor : UIColor.white]
        
        navigationItem.hidesBackButton = true

        self.navigationController?.navigationBar.setTransparent(true)

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5)
        layout.minimumInteritemSpacing = 5

        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        selectedInterestsValues = [String](repeating: "0", count: interestsImage.count)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "toApp" {
                
                let barViewControllers = segue.destination as! UITabBarController
                barViewControllers.viewControllers?.forEach{
                    if let navVC = $0 as? UINavigationController {
                        let tableVC = navVC.viewControllers.first as! HomeViewController
                        tableVC.userDetails = userDetails
                        
                    }
                    
                }
                
            }
        }
        segue.destination.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestsImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SelectInterestsCollectionViewCell
        
        if selectedInterestsValues[indexPath.item] != "0" {
            cell.selectInterestsImageView.image = interestsImageSELECTED[indexPath.item]
            
        } else {
            cell.selectInterestsImageView.image = interestsImage[indexPath.item]
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let finalView = UICollectionReusableView()
            
        if kind ==  UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! SelectInterestsCollectionReusableView
            
            footerView.doneButton.layer.borderWidth = 1
            footerView.doneButton.layer.borderColor = UIColor.white.cgColor
            footerView.doneButton.isUserInteractionEnabled = true
            footerView.backgroundColor = UIColor.clear// UIColor(rgb:0x7B6BCE)
            return footerView
            
        } else {
            return finalView
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if selectedInterestsValues[indexPath.item] != "0" {
            selectedInterestsValues[indexPath.item] = "0"
        } else {
            selectedInterestsValues[indexPath.item] = String(indexPath.item+1)

        }
        print("selectedInterestsValues = \(selectedInterestsValues)")

        self.collectionView.reloadData()

        // TODO: - verificare stare buton

    }
}
