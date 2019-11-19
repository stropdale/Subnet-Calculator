//
//  ViewController.swift
//  Subnet Calculator
//
//  Created by Richard Stockdale on 19/11/2019.
//  Copyright © 2019 RGB Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Input
    @IBOutlet weak var ipAddressField: UITextField!
    @IBOutlet weak var maskField: UITextField!
    @IBOutlet weak var prefixField: UITextField!
    
    // Results
    
    @IBOutlet weak var startingHostLabel: UILabel!
    @IBOutlet weak var maxHostsLabel: UILabel!
    @IBOutlet weak var endingHostLabel: UILabel!
    
    @IBOutlet weak var networkAddrLabel: UILabel!
    @IBOutlet weak var networkClassLabel: UILabel!
    @IBOutlet weak var broadcastAddrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

