//
//  ETHManager.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import Foundation
import BigInt
import web3swift

final class ETHManager {
    
    static let shared = ETHManager()
    
    // eth variables
    let web3Ropsten = Web3.InfuraRopstenWeb3()
    let keystoreManager = KeystoreManager.managerForPath(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/keystore")
    var ks: EthereumKeystoreV3?
    var etherBalance: String = "0.0"

    // functions
    
    func checkWallet() -> Bool {
        if (keystoreManager?.addresses?.count != 0) {
            ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as? EthereumKeystoreV3
            self.getBalance()
            return true
        } else {
            return false
        }
    }
    
    func getAddress() -> String {
        let sender = ks?.addresses?.first
        return sender!.address
    }
    
    func getBalance() {
        let sender = ks?.addresses?.first
        DispatchQueue.global().async {
            let balanceResult = self.web3Ropsten.eth.getBalance(address: sender!)
            guard case .success(let balance) = balanceResult else {return}
            DispatchQueue.main.async {
                print("Balance of " + sender!.address + " = " + Web3Utils.formatToEthereumUnits(balance)!)
                self.etherBalance = Web3Utils.formatToEthereumUnits(balance)!
            }
        }
    }
}
