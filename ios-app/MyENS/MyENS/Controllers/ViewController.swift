//
//  ViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit
import BigInt
import web3swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create Ethereum keystore
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
        var ks: EthereumKeystoreV3?
        if (keystoreManager?.addresses?.count == 0) {
            ks = try! EthereumKeystoreV3(password: "MYPASSWORD")
            let keydata = try! JSONEncoder().encode(ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
        } else {
            ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as? EthereumKeystoreV3
        }
        guard let sender = ks?.addresses?.first else {return}
        print(sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

