//
//  WalletViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit
import FontAwesome_swift

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
    }
    
    @IBAction func qrCodeTapped(_ sender: Any) {
        // make qr code popup
    }
    
    @IBAction func copyAddressTapped(_ sender: Any) {
        UIPasteboard.general.string = addr
    }
}
