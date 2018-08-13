//
//  OffersViewController.swift
//  DMT
//
//  Created by Boggy on 06/08/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController	 {


    @IBOutlet weak var collectionView: UICollectionView!
    
    var clickedOfferDetailFromServer: ClickedOfferDetail?
    var userDetails: UserDetails?
    var offerDetails: [OffersDetail] = []
    var offerNumber: Int?
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func segmentedOffers(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getAllOffersFromServer()
            prepareTalbeView()
        case 1:
            break
        default:
            break
        }
    }
    
    func prepareTalbeView() {
        let nib = UINib(nibName: OffersCollectionViewCell.NibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: OffersCollectionViewCell.ReuseIdentifier)
    }
    
    func getAllOffersFromServer() {
        var params = Parameters()
        params["request"] = "0"
        params["id_user"] = userDetails?.idUser
        let loadingScreen = UIViewController.displaySpinner(onView: self.view)
        Services.getAllOffers(params: params) { [weak self] result in
            UIViewController.removeSpinner(spinner: loadingScreen)
            switch result {
            case .success(let json):
                guard let responseFromJSON = json.response else {
                    return
                }
                guard let messageFromJSON = json.msg else {
                    return
                }
                guard let resultFromJSON = json.result else {
                    return
                }
                
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
                            self?.offerNumber = resultFromJSON.count
                            self?.offerDetails = resultFromJSON
                            print(self?.offerDetails[1].numeLocatie as Any)
                            
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("celula selectata -  \(indexPath.item)!")
        
        var params = Parameters()
        
        params["request"] = "1"
        params["id_user"] = userDetails?.idUser
        params["id_oferta"] = self.offerDetails[indexPath.item].idOferta
        
        Services.getOfferDetails(params: params) { [weak self] result in
            switch result {
            case .success(let json):
                
                guard let responseFromJSON = json.response else {
                    return
                }
                guard let messageFromJSON = json.msg else {
                    return
                }
                guard let resultFromJSON = json.result else {
                    return
                }
                
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
                            self?.clickedOfferDetailFromServer = resultFromJSON
                            self?.performSegue(withIdentifier: "showDetail", sender: nil)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerDetails.count // il gaseste ca nil
    }
}

