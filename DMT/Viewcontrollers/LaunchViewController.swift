//
//  LaunchViewController.swift
//  DMT
//
//  Created by Boggy on 05/09/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var backgroundimage: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: Selector(("dismissLVC")), userInfo: nil, repeats: false)


        // Do any additional setup after loading the view.
    }
    
    func dismissLVC() {
        print("idk")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }	
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
//       backgroundimage.alpha = 0.0
//       logo.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.0, animations: {
            
            //bg anim
            
        }, completion: nil)
        
        UIView.animate(withDuration: 2, animations: {
            
            //logo anim
            
        }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
