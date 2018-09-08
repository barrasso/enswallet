//
//  LoginViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var heroText: UILabel!
    @IBOutlet weak var createWalletButton: UIButton!
    @IBOutlet weak var restoreWalletButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createWalletTapped(_ sender: Any) {
        // setup new wallet and save keystore to device
        
        // segue to onboarding process
        self.performSegue(withIdentifier: "createWallet", sender: nil)
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
