//
//  OffersViewController.swift
//  DMT
//
//  Created by Boggy on 06/08/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController     {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var userDetails: UserDetails?
    var offerDetailsLuate: [HybridOffersDetails] = []
    var offerDetailsPuse: [HybridOffersDetails] = []
    var offerDetails: [HybridOffersDetails] = []
    var offerNumberLuate: Int?
    var offerNumberPuse: Int?
    let reuseIdentifier = "cell"
    var index: Int = 2
    var offerNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OffersViewController - viewDidLoad)")
        getAllHybridOffersFromServer()
        prepareCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func segmentedOffers(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            index = 0
            offerDetails = offerDetailsLuate
            self.collectionView.reloadData()
        case 1:
            index = 1
            offerDetails = offerDetailsPuse
            self.collectionView.reloadData()
        default:
            break
        }
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        print("ViewController - \(OffersCollectionViewCell.ReuseIdentifier)")
        let nib = UINib(nibName: OffersCollectionViewCell.NibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: OffersCollectionViewCell.ReuseIdentifier)
    }
}
extension OffersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCollectionViewCell.ReuseIdentifier, for: indexPath) as! OffersCollectionViewCell
        
        cell.load()
        cell.headerLabel.text = self.offerDetails[indexPath.item].titluOferta
        cell.locationLabel?.text = self.offerDetails[indexPath.item].numeLocatie
        cell.priceLabel.text = self.offerDetails[indexPath.item].pretOferta
        cell.jobLabel.text = self.offerDetails[indexPath.item].specializare
        cell.locationLabel?.textColor = UIColor(red: 0.5, green: 0.44, blue: 0.87, alpha: 1)
        cell.priceLabel.textColor = UIColor.white
        cell.jobLabel.textColor = UIColor(red: 0.5, green: 0.44, blue: 0.87, alpha: 1)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var offerNumber = 0
        if index == 0 {
            offerNumber = offerNumberLuate!
            print(offerNumber)
        }
        if index == 1 {
            offerNumber = offerNumberPuse!
            print(offerNumber)
        }
        return offerNumber
    }
    
    func getAllHybridOffersFromServer() {
        var params = Parameters()
        print("am intrat in functie")
        params["request"] = "0"
        params["id_user"] = userDetails?.idUser
        let loadingScreen = UIViewController.displaySpinner(onView: self.view)
        Services.getHybridOffers(params: params) { [weak self] result in
            UIViewController.removeSpinner(spinner: loadingScreen)
            switch result {
            case .success(let json):
                guard let responseFromJSON = json.response else {
                    return
                }
                guard let messageFromJSON = json.msg else {
                    return
                }
//                                guard let resultFromJSON = json.result else {
//                                    return
//                                }
                
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
                            self?.offerNumberLuate = json.result["oferteluate"]?.count
                            print(self?.offerNumberLuate)
                            self?.offerNumberPuse = json.result["ofertepuse"]?.count
                            print(self?.offerNumberPuse)
                            self?.offerDetailsLuate = json.result["oferteluate"]! as! [HybridOffersDetails]
                            self?.offerDetailsPuse = json.result["ofertepuse"]! as! [HybridOffersDetails]
                            
                            
                            
                            self?.collectionView.reloadData()
                            
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
}

