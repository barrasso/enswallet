//
//  LoginViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit
import web3swift

class LoginViewController: UIViewController {

    @IBOutlet weak var heroText: UILabel!
    @IBOutlet weak var createWalletButton: UIButton!
    @IBOutlet weak var restoreWalletButton: UIButton!
    
    // MARK: - Lifecycle ♻️
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ETHManager.shared.checkWallet() {
            // go home
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions 🅱️
    
    @IBAction func createWalletTapped(_ sender: Any) {
        // setup new wallet and save keystore to device
        initEthereumKeystore()
        
        // segue to onboarding process
        self.performSegue(withIdentifier: "createWallet", sender: nil)
    }
    
    func initEthereumKeystore() {
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
        var ks: EthereumKeystoreV3?
        if (keystoreManager?.addresses?.count == 0) {
            ks = try! EthereumKeystoreV3(password: UUID().uuidString)
            let keydata = try! JSONEncoder().encode(ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
        } else {
            ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as? EthereumKeystoreV3
        }
        guard let sender = ks?.addresses?.first else {return}
        print(sender)
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
