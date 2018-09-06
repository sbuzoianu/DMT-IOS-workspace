//
//  JobListViewController.swift
//  DMT
//
//  Created by Boggy on 05/09/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class JobListViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //depending upon direction of collection view
//        
//        self.collectionView?.setCollectionViewLayout(layout, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareCollectionView() {
        
        
        collectionView.dataSource = self
        print("ViewController - \(JobCollectionViewCell.ReuseIdentifier)")
        let nib = UINib(nibName: JobCollectionViewCell.NibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: JobCollectionViewCell.ReuseIdentifier)
    }
}

extension JobListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCollectionViewCell.ReuseIdentifier, for: indexPath) as! JobCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("10")
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("zi daca macar intri aici")
        let cellSize = collectionView.frame.size.width/2
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
}
