//
//  WalletViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var gravatarImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let addr = ETHManager.shared.getAddress()

    // MARK: - Lifecycle ♻️

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadGravatar()
        addressLabel.text = addr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Functions 🛠
    
    func downloadGravatar() {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: "https://www.gravatar.com/avatar/\(self.addr)?s=64&d=retro")!)
            DispatchQueue.main.async {
                self.gravatarImageView.image = UIImage(data: data!)
            }
        }
        gravatarImageView.image = UIImage()
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
