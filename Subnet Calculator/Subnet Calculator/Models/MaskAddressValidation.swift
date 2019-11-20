//
//  MaskAddressValidation.swift
//  Subnet Calculator
//
//  Created by Richard Stockdale on 20/11/2019.
//  Copyright © 2019 RGB Consulting. All rights reserved.
//

import Foundation

struct Validate {
    static func ipIsValid(address: String) -> Bool {
        let parts = address.components(separatedBy: ".")
        let nums = parts.compactMap { Int($0) }
        return parts.count == 4 && nums.count == 4 && nums.filter { $0 >= 0 && $0 < 256}.count == 4
    }
    
    static func maskIsValid(mask: String) -> Bool {
        let parts = mask.components(separatedBy: ".")
        if parts.count != 4 {
            return false
        }
        
        let nums = parts.compactMap { Int($0) }
        
        var last: Int?
        for num in nums {
            if num > 255 || num < 0 {
                return false
            }
            
            if let last = last {
                if num > last {
                    return false
                }
            }
            
            last = num
        }
        
        return true
    }
    
    static func prefixIsValid(prefix: String) -> Bool {
        guard let prefixInt = Int(prefix) else {
            return false
        }
        
        return prefixInt < 31 && prefixInt > -1
    }
}
