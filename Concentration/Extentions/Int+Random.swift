//
//  Int+Random.swift
//  Concentration
//
//  Created by Takasur Azeem on 14/02/2021.
//

import Foundation

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
    
}
