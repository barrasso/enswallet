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
    
    var timer: Timer = Timer()
    let heroTextContent: [String] = ["No more long addresses.", "Send money to friends.", "Choose your wallet name.", "Your personal ENS wallet."]
    
    // MARK: - Lifecycle ♻️
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startHeroTextReel()

        if ETHManager.shared.checkWallet() {
            // go home
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
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
    
    // MARK: - Helper Functions 🛠

    func startHeroTextReel() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { (timer) in
            UIView.animate(withDuration: 0.6, animations: {
                self.heroText.alpha = 0
            })
            self.heroText.text = self.heroTextContent[Int(arc4random_uniform(4))]
            UIView.animate(withDuration: 0.6, animations: {
                self.heroText.alpha = 1
            })
        })
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
    
}
