//
//  BackupViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit

class BackupViewController: UIViewController {

    @IBOutlet weak var recoveryPhraseView: UIView!
    @IBOutlet weak var recoveryPhraseText: UILabel!
    
    @IBOutlet weak var verifyPhraseButton: UIButton!
    @IBOutlet weak var skipBackupButton: UIButton!
    
    // MARK: - Lifecycle ♻️
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions 🅱️
    
    @IBAction func verifyRecoveryTapped(_ sender: Any) {
        
    }
    
    @IBAction func skipBackupTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "If you lose your recovery phrase, you will lose access to your wallet.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Fuck it", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "secureWallet", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
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
