//
//  ENSViewController.swift
//  MyENS
//
//  Created by mbarrass on 9/8/18.
//  Copyright © 2018 ethsociety. All rights reserved.
//

import UIKit

class ENSViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var bidButton: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var bidContainerView: UIView!
    @IBOutlet weak var auctionContainerView: UIView!
    
    var error: String?
    
    // MARK: - Lifecycle ♻️
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        availabilityLabel.isHidden = true
        bidButton.isUserInteractionEnabled = false
        bidButton.isHidden = true
        auctionContainerView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions 🅱️
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            bidContainerView.isHidden = false
            auctionContainerView.isHidden = true
            break
        case 1:
            bidContainerView.isHidden = true
            auctionContainerView.isHidden = false
            break
        default:
            break
        }
    }
    
    
    // MARK: - Helper Functions 🛠
    
    func isError() -> Bool {
        error = ""
        if (self.searchBar.text?.count)! < 7 {
            error = "A minimum of 7 characters is required."
            return true
        }
        return false
    }
    
    func showError(_ err: String) {
        let alert = UIAlertController(title: "Error", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    // MARK: - Search Delegate 🔍
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        if !isError() {
            // perform query
            
        } else {
            showError(error!)
        }
    }
}
