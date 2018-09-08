//
//  SecureWalletViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit
import LocalAuthentication

class SecureWalletViewController: UIViewController {

    @IBOutlet weak var useFaceIDButton: UIButton!
    @IBOutlet weak var usePinCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func useFaceIDtapped(_ sender: Any) {
        useFaceID()
    }
    
    func useFaceID() {
        guard #available(iOS 8.0, *) else {
            return print("Not supported")
        }
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error as Any)
        }
        let reason = "Face ID authentication"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            guard isAuthorized == true else {
                return print(error as Any)
            }
            // success, moving along
            DispatchQueue.main.async { [unowned self] in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Root", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "rootViewController") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
