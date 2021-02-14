//
//  Array+only.swift
//  Concentration
//
//  Created by Takasur Azeem on 14/02/2021.
//

import Foundation

extension Array {
    
    var only: Element? {
        self.count == 1 ? first : nil
    }
    
}
