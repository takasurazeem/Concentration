//
//  Card.swift
//  Concentration
//
//  Created by Takasur Azeem on 14/02/2021.
//

import Foundation

struct Card : Hashable {
    
    var id: Int
    var isFaceUp = true
    var isMatched = false
    var numberOfTimesWasRevealed = 0
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
    
    init() {
        self.id = Card.getUniqueIdentifier()
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
