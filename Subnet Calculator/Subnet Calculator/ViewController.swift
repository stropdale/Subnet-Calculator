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
    @IBOutlet weak var errorLabel: UILabel!
    
    private var subnetDetails: IPSubnetCalculationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingHostLabel.text = "?"
        maxHostsLabel.text = "?"
        endingHostLabel.text = "?"
        
        networkAddrLabel.text = "?"
        networkClassLabel.text = "?"
        broadcastAddrLabel.text = "?"
        errorLabel.text = ""
    }
    
    @IBAction func calculateTapped(_ sender: Any) {
        errorLabel.text = ""
        
        guard let ip = ipAddressField.text else {
            errorLabel.text = "No IP address entered"
            
            return
        }
        
        if !Validate.ipIsValid(address: ip) {
            errorLabel.text = "IP is not valid"
            
            return
        }
        
        if maskField.text?.isEmpty ?? true && prefixField.text?.isEmpty ?? true {
            errorLabel.text = "No mask or prefix entered"
            
            return
        }
        
        let maskFieldLength = maskField.text?.count ?? 0
        let prefixFieldLength = prefixField.text?.count ?? 0
        
        
        
        if (maskFieldLength == prefixFieldLength) && maskFieldLength == 0  {
            errorLabel.text = "Please enter a Mask or Prefix"
            
            return
        }
        
        if maskFieldLength > 0 && prefixFieldLength > 0 {
            errorLabel.text = "Mask and prefix entered. Please delete one and tap calculate again"
            
            return
        }
        
        if maskFieldLength != 0 {
            if Validate.maskIsValid(mask: maskField.text!) {
                calculateFromMask()
            }
            else {
                errorLabel.text = "Mask is not valid"
            }
        }
        
        if prefixFieldLength != 0 {
            if Validate.prefixIsValid(prefix: prefixField.text!) {
                calculateFromPrefix()
            }
            else {
                errorLabel.text = "Prefix is not valid"
            }
        }
    }
    
    private func calculateFromPrefix() {
        guard let prefix = Int.init(prefixField!.text!) else {
            errorLabel.text = "Prefix was not a number"
            
            return
        }
        
        subnetDetails = IPSubnetCalculationModel(ipv4: ipAddressField.text!, prefix: prefix)
        updateUI()
    }
    
    private func calculateFromMask() {
        subnetDetails = IPSubnetCalculationModel.init(ipv4: ipAddressField.text!, subnetMask: maskField.text!)
        updateUI()
    }
    
    private func updateUI() {
        guard let subnetDetails = subnetDetails else {
            return
        }
        
        startingHostLabel.text = subnetDetails.startHostAddress
        maxHostsLabel.text = "\(subnetDetails.numberOfHosts ?? 0)"
        endingHostLabel.text = subnetDetails.endHostAddress
        
        networkAddrLabel.text = subnetDetails.networkAddress
        networkClassLabel.text = subnetDetails.networkClass
        broadcastAddrLabel.text = subnetDetails.broadcastAddress
        maskField.text = subnetDetails.subnetMask
        
        if let prefix = subnetDetails.prefix {
            prefixField.text = "\(prefix)"
        }
        else {
            prefixField.text = ""
        }
        
        errorLabel.text = ""
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    }
    
    
}

